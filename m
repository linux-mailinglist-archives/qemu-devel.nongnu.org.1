Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF40E7E8B5C
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 16:30:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1pum-0003gH-Kv; Sat, 11 Nov 2023 10:28:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r1pul-0003g9-5X
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 10:28:51 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r1puj-0008FQ-4w
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 10:28:50 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cc34c3420bso24494015ad.3
 for <qemu-devel@nongnu.org>; Sat, 11 Nov 2023 07:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1699716528; x=1700321328;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x+oSJeCf4RdOLBHx96SnjNxtGcU5a3/Vk6IRcTMXoao=;
 b=hejO/NzI+XsQih8X9B2WV912RPp8vDUJZoPMq9GBiGoiw3z/D1lI/lHi6j2WfSMWD5
 LgWbH3RVuLZv1eXlx9iIdU7/N35uTCJ9KciWTmDjtjZf3okWfGAjV/Xo0qqhbfwjHIHZ
 okGK9u6L1SXIF+LjjlgzpuixfUisbg4MbaUcY8vVW7HgSoe81DHPGmzSUfA+alHh1t/p
 F8EuXVSyCdZrPByzPXpSgOb4kIyNSOpUAU7IjfX+JjYe/6QQvpqIlH2P3Zyo6ItxlU6L
 VjBikApSRNRgsgsxQxGHE3q0+W+nQGcwdCuD8t9PX0Krq6kZi7SY+voRXTrfhopCEKx2
 FYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699716528; x=1700321328;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x+oSJeCf4RdOLBHx96SnjNxtGcU5a3/Vk6IRcTMXoao=;
 b=DJjSidfMZNnUxQ5KjLwwBjXBxp/whb9Npkez1htMyv8b64BNhyO5RIe0MFv6xaQNgE
 t1p7tbttWLwVkkXDZf4wViTFhBU17waL0TmewEvJcCzdyizzQeW0gUkEAFbBVm5iMpt2
 3r6fLqa8iHDxHV2JTypFq6I9E63JJ2duhS0WepgrvkV5UM86OgYOI2b0rWuOFT1v5SfD
 3HKqejIXfveoRiRT3ergM2/lDPG2Z0es2xVyq3+WJG1UyDTV8XdHNjHVpRXBbO8Ryz66
 UmZuX+IJO0G73/s479cwfYNoL28O/zXi/hvhP+pmFRWV0FhshodHpe2OCeURoy4leNf0
 fzeg==
X-Gm-Message-State: AOJu0Yz4XGCQEGfGbl0Vqisvb5sB6MZO3Voz7Av0VGrnB1ZtY3+Yfbc9
 V6ThkHiYjiR+dBjqdIr5ouBPLw==
X-Google-Smtp-Source: AGHT+IESHITMyktL08I4j6RmEBoiu69nhnkitGvYOX0hR83zeDkIUiteBoBOPV97sMz4XTvYkmHgog==
X-Received: by 2002:a17:902:b907:b0:1cc:d981:a399 with SMTP id
 bf7-20020a170902b90700b001ccd981a399mr1636007plb.31.1699716527645; 
 Sat, 11 Nov 2023 07:28:47 -0800 (PST)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 l4-20020a170902eb0400b001c61901ed2esm1401381plb.219.2023.11.11.07.28.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Nov 2023 07:28:47 -0800 (PST)
Message-ID: <8439be4e-a739-4cbd-a569-89b6c7f68ab9@daynix.com>
Date: Sun, 12 Nov 2023 00:28:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
Content-Language: en-US
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Andrew Melnychenko <andrew@daynix.com>
References: <58fb3b75-dd69-4715-a8ec-4c3df3b7e4c5@daynix.com>
 <CAOEp5Oern10jW8Pi-_mceU_ZJVD=a1f3tW8rB2O4efLX45-nvw@mail.gmail.com>
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
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAOEp5Oc5VzWk7e8gKHfHan1odge39bRUh-ZMojCvkQiTFpXdGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
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

On 2023/11/03 22:14, Yuri Benditovich wrote:
> 
> 
> On Fri, Nov 3, 2023 at 11:55 AM Akihiko Odaki <akihiko.odaki@daynix.com 
> <mailto:akihiko.odaki@daynix.com>> wrote:
> 
>     On 2023/11/03 18:35, Yuri Benditovich wrote:
>      >
>      >
>      > On Thu, Nov 2, 2023 at 4:56 PM Akihiko Odaki
>     <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>
>      > <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>> wrote:
>      >
>      >     On 2023/11/02 19:20, Yuri Benditovich wrote:
>      >      >
>      >      >
>      >      > On Thu, Nov 2, 2023 at 11:33 AM Michael S. Tsirkin
>      >     <mst@redhat.com <mailto:mst@redhat.com>
>     <mailto:mst@redhat.com <mailto:mst@redhat.com>>
>      >      > <mailto:mst@redhat.com <mailto:mst@redhat.com>
>     <mailto:mst@redhat.com <mailto:mst@redhat.com>>>> wrote:
>      >      >
>      >      >     On Thu, Nov 02, 2023 at 11:09:27AM +0200, Yuri
>     Benditovich wrote:
>      >      >      > Probably we mix two different patches in this
>     discussion.
>      >      >      > Focusing on the patch in the e-mail header:
>      >      >      >
>      >      >      > IMO it is not acceptable to fail QEMU run for one
>     feature
>      >     that we
>      >      >     can't make
>      >      >      > active when we silently drop all other features in
>     such a
>      >     case.
>      >      >
>      >      >     If the feature is off by default then it seems more
>     reasonable
>      >      >     and silent masking can be seen as a bug.
>      >      >     Most virtio features are on by default this is why it's
>      >      >     reasonable to mask them.
>      >      >
>      >      >
>      >      > If we are talking about RSS: setting it initially off is the
>      >     development
>      >      > time decision.
>      >      > When it will be completely stable there is no reason to
>     keep it
>      >     off by
>      >      > default, so this is more a question of time and of a
>     readiness of
>      >     libvirt.
>      >
>      >     It is not ok to make "on" the default; that will enable RSS
>     even when
>      >     eBPF steering support is not present and can result in
>     performance
>      >     degradation.
>      >
>      >
>      > Exactly as it is today - with vhost=on the host does not suggest RSS
>      > without  eBPF.
>      > I do not understand what you call "performance degradation", can you
>      > describe the scenario?
> 
>     I was not clear, but I was talking about the case of vhost=off or peers
>     other than tap (e.g., user). rss=on employs in-qemu RSS, which incurs
>     overheads for such configurations.
> 
> 
> So, vhost=off OR peers other than tap:
> 
> In the case of peers other than tap (IMO) we're not talking about 
> performance at all.
> Backends like "user" (without vnet_hdr) do not support _many_ 
> performance-oriented features.
> If RSS is somehow "supported" for such backends this is rather a 
> misunderstanding (IMO again).

We do not need to ensure good performance when RSS is enabled by the 
guest for backends without eBPF steering program as you say. In-QEMU RSS 
is only useful for testing and not meant to improve the performance.

However, if you set rss=on, QEMU will advertise the availability of RSS 
feature. The guest will have no mean to know if it's implemented in a 
way not performance-wise so it may decide to use the feature to improve 
the performance, which can result in performance degradation. Therefore, 
it's better not to set rss=on for such backends.

