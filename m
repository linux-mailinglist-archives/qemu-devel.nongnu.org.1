Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B29357E9C5D
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 13:46:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2WJA-0006Jv-MN; Mon, 13 Nov 2023 07:44:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r2WJ6-0006JR-82
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 07:44:48 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r2WJ2-0003fG-9c
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 07:44:47 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1cc5b7057d5so38802335ad.2
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 04:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1699879481; x=1700484281;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O1eSd/gkDSrSDAE5P90mysgkJnPZsNmwasRdoIqKqtY=;
 b=Cw5U6i5nmptjhcU++NnbCeQRn1XbDpdgfxCFXdQshnEdig5reyF2ZaGPUeAISaCLcP
 x+8mpTS8c1zi6jdtdbbb3XsGQxTEUp7D2xyA3i2wYGTObf0HZTyuiVEKmEuybTAf9iFi
 9u4sdQVhmTbvSu/bKKAS2T9OBF0VpvgHTzaJ0ft1E6Rsev1BGdnoRf/9BKXaE8xHxpXs
 9F2qgYEtesmQPdoOdnB7eSltUBeiQ+yv81n4+qGRiajyf3heOut5DZpSAd7ccHCW73t4
 DFzmadpmEQTFYe312R45nLUx7+HJrBgT6sDMJwVlqXfJK1JZKV7ix3xdACjhV2SmyWvG
 exbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699879481; x=1700484281;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O1eSd/gkDSrSDAE5P90mysgkJnPZsNmwasRdoIqKqtY=;
 b=jde2LEdY3Lt/7ZflFsMiZkAwkmJZaFGzqUVGsf6ipyMPYG15H0x4EW4MGJKj1AmeGl
 BUEUw/h2bzGEEKzv87wsgJi6OQWI24a5ybT2vMjZqDyOgYLh1Y32H7DKEkfwwf4g72nI
 lP3lZ59wf1D5cYHMoHQszkW11pCo4qTnbAXHAIPiiHQrLHQfEpcu1+1hWFfzDy85Pfoi
 JL/4KJjYLwFi6bpp8DaFmobjOEproRGX72qgf/ue6nTcYl8qH+3EfrmK0kMuaSsTNj8l
 K81TkFwriumPj3mcwUenkBujUBxG9iWebdeVLC/tZvYy9tFoRWBWmV6QzvA3GVlwaIV5
 NXKQ==
X-Gm-Message-State: AOJu0YyrhJ9xKiAaBTv+hN8uRtP4/oNUkMgMHfJMGn7G4Pz+ATt1NqCM
 17na7Xe6LQeBKy4Y4x2f41CZxg==
X-Google-Smtp-Source: AGHT+IFR1c3sb3eAz+piSfVuzpShk0iSH5TobkGrncrxD4+mNXFWE4OpyapyKkTbStJYslAY7+y3ig==
X-Received: by 2002:a17:902:ab0f:b0:1c0:cbaf:6930 with SMTP id
 ik15-20020a170902ab0f00b001c0cbaf6930mr7228512plb.54.1699879481076; 
 Mon, 13 Nov 2023 04:44:41 -0800 (PST)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 je12-20020a170903264c00b001bde6fa0a39sm3972781plb.167.2023.11.13.04.44.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 04:44:40 -0800 (PST)
Message-ID: <3c8af942-ca7d-4528-975e-2935718a2428@daynix.com>
Date: Mon, 13 Nov 2023 21:44:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Andrew Melnychenko <andrew@daynix.com>
References: <58fb3b75-dd69-4715-a8ec-4c3df3b7e4c5@daynix.com>
 <8880b6f9-f556-46f7-a191-eeec0fe208b0@daynix.com>
 <CACGkMEv=A0KS-LtgZmsMehdoUL=EuQzhkfNipKaV1kdUr2Y5Bw@mail.gmail.com>
 <d0db0fb1-0a58-45b7-a623-df6ee9096e2e@daynix.com>
 <20231101023805-mutt-send-email-mst@kernel.org>
 <39a02a4c-f8fa-437c-892f-caca84b8d85d@daynix.com>
 <20231101050838-mutt-send-email-mst@kernel.org>
 <e469b33b-c3f3-4d88-bdf2-508c4a35c827@daynix.com>
 <CAOEp5OcDMdKKPHSVd-GxT-GkBpvbWkMijSBgwihPsEnxmDR7eA@mail.gmail.com>
 <20231102053202-mutt-send-email-mst@kernel.org>
 <CAOEp5OefD2LN2MDnEkE=DOMSX0Jw8Z6gAiKAag4dtkecmr1Jgg@mail.gmail.com>
 <2fbdee21-60f4-49ff-b61b-923c895f90ba@daynix.com>
 <CAOEp5Oc+wGmxTAezMz4f03kuqsngHAcpi7pqPQDT=PWuy=L7BA@mail.gmail.com>
 <dbd1d662-bf90-4982-b316-281923a0d778@daynix.com>
 <CAOEp5Oc5VzWk7e8gKHfHan1odge39bRUh-ZMojCvkQiTFpXdGg@mail.gmail.com>
 <8439be4e-a739-4cbd-a569-89b6c7f68ab9@daynix.com>
 <CAOEp5Oee2qinrZJgMMxUQt6zmPVFPCnThfqnLFSWqsSyAoHpjQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAOEp5Oee2qinrZJgMMxUQt6zmPVFPCnThfqnLFSWqsSyAoHpjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 2023/11/13 20:44, Yuri Benditovich wrote:
> 
> 
> On Sat, Nov 11, 2023 at 5:28 PM Akihiko Odaki <akihiko.odaki@daynix.com 
> <mailto:akihiko.odaki@daynix.com>> wrote:
> 
>     On 2023/11/03 22:14, Yuri Benditovich wrote:
>      >
>      >
>      > On Fri, Nov 3, 2023 at 11:55 AM Akihiko Odaki
>     <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>
>      > <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>> wrote:
>      >
>      >     On 2023/11/03 18:35, Yuri Benditovich wrote:
>      >      >
>      >      >
>      >      > On Thu, Nov 2, 2023 at 4:56 PM Akihiko Odaki
>      >     <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>
>     <mailto:akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>>
>      >      > <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>
>      >     <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>>> wrote:
>      >      >
>      >      >     On 2023/11/02 19:20, Yuri Benditovich wrote:
>      >      >      >
>      >      >      >
>      >      >      > On Thu, Nov 2, 2023 at 11:33 AM Michael S. Tsirkin
>      >      >     <mst@redhat.com <mailto:mst@redhat.com>
>     <mailto:mst@redhat.com <mailto:mst@redhat.com>>
>      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
>     <mailto:mst@redhat.com <mailto:mst@redhat.com>>>
>      >      >      > <mailto:mst@redhat.com <mailto:mst@redhat.com>
>     <mailto:mst@redhat.com <mailto:mst@redhat.com>>
>      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
>     <mailto:mst@redhat.com <mailto:mst@redhat.com>>>>> wrote:
>      >      >      >
>      >      >      >     On Thu, Nov 02, 2023 at 11:09:27AM +0200, Yuri
>      >     Benditovich wrote:
>      >      >      >      > Probably we mix two different patches in this
>      >     discussion.
>      >      >      >      > Focusing on the patch in the e-mail header:
>      >      >      >      >
>      >      >      >      > IMO it is not acceptable to fail QEMU run
>     for one
>      >     feature
>      >      >     that we
>      >      >      >     can't make
>      >      >      >      > active when we silently drop all other
>     features in
>      >     such a
>      >      >     case.
>      >      >      >
>      >      >      >     If the feature is off by default then it seems more
>      >     reasonable
>      >      >      >     and silent masking can be seen as a bug.
>      >      >      >     Most virtio features are on by default this is
>     why it's
>      >      >      >     reasonable to mask them.
>      >      >      >
>      >      >      >
>      >      >      > If we are talking about RSS: setting it initially
>     off is the
>      >      >     development
>      >      >      > time decision.
>      >      >      > When it will be completely stable there is no reason to
>      >     keep it
>      >      >     off by
>      >      >      > default, so this is more a question of time and of a
>      >     readiness of
>      >      >     libvirt.
>      >      >
>      >      >     It is not ok to make "on" the default; that will
>     enable RSS
>      >     even when
>      >      >     eBPF steering support is not present and can result in
>      >     performance
>      >      >     degradation.
>      >      >
>      >      >
>      >      > Exactly as it is today - with vhost=on the host does not
>     suggest RSS
>      >      > without  eBPF.
>      >      > I do not understand what you call "performance
>     degradation", can you
>      >      > describe the scenario?
>      >
>      >     I was not clear, but I was talking about the case of
>     vhost=off or peers
>      >     other than tap (e.g., user). rss=on employs in-qemu RSS,
>     which incurs
>      >     overheads for such configurations.
>      >
>      >
>      > So, vhost=off OR peers other than tap:
>      >
>      > In the case of peers other than tap (IMO) we're not talking about
>      > performance at all.
>      > Backends like "user" (without vnet_hdr) do not support _many_
>      > performance-oriented features.
>      > If RSS is somehow "supported" for such backends this is rather a
>      > misunderstanding (IMO again).
> 
>     We do not need to ensure good performance when RSS is enabled by the
>     guest for backends without eBPF steering program as you say. In-QEMU
>     RSS
>     is only useful for testing and not meant to improve the performance.
> 
>     However, if you set rss=on, QEMU will advertise the availability of RSS
>     feature. The guest will have no mean to know if it's implemented in a
>     way not performance-wise so it may decide to use the feature to improve
>     the performance, which can result in performance degradation.
>     Therefore,
>     it's better not to set rss=on for such backends.
> 
> 
> I still do not understand what is the scenario where you see or suspect 
> the mentioned "performance degradation".
> We can discuss whether such a problem exists as soon as you explain it.

The scenario is that:
- rss=on,
- A backend without eBPF steering support is in use, and
- The guest expects VIRTIO_NET_F_RSS has little overheads as hardware 
RSS implementations do.

I consider the risk of the performance degradation in such a situation 
is the reason why virtio-net emits a warning ("Can't load eBPF RSS - 
fallback to software RSS") when in-QEMU RSS is in use.

