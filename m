Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B798C7EAABD
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 08:06:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2nSb-0002NT-RL; Tue, 14 Nov 2023 02:03:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r2nSY-0002NF-OD
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 02:03:43 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r2nSU-0005w8-0b
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 02:03:42 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6b77ab73c6fso4090952b3a.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 23:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1699945415; x=1700550215;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uwOkxso6IKuq57jpXNQfljB76+Ogi+dh97xjTn9Jh3c=;
 b=z5vh83P+Nlp528I0usm/GxTf4zqzOBV48ckmUD6MZcF8ZiLgE8kxdfOOECBABBTmUG
 RkEFN7zUygGWvUYSUURw7csenJBD7D5pi5HRcIeqoJ0kcAh5/fczSodBHHEvHK/OETqM
 +vwHcJFHFrqdwclp3D0g8/lPqMeZl0wO5SGO3xWkdrlkB+fF6Bu8BObzOPmyPzjOm7Mj
 fMbdWyUCxiV1e+rEsjhgERXJQcx6R2kr929kuIUGvp+Rhl7WFR7oRx+PnGtEZ133NVhk
 VgULRjw5JnEGE8f2i6DXs6QGZULxYDUYqBJrYPfWABgfyKTSpoPkSawMttLiPg3FMc4W
 mnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699945415; x=1700550215;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uwOkxso6IKuq57jpXNQfljB76+Ogi+dh97xjTn9Jh3c=;
 b=TiIptT+vaIhUSoKdiDQs1eYD3nVSMUGwE/PhJcEBm0B1Xljv5P5wpKuoUbU1u5FfUt
 sD7CIef+K1F5/RhJBU2lpHWYn30S24F3Ud8hRvquL4mK+x6j0eTbts9eMuG67CCQQZK4
 TERg6pY5dF/R+ISUtxYZudSRsBYKV9o6Pm50jQEk60V4b3rpejJcdDghE+lIbW5ZmqD4
 PnSYSmkcULf4UxOGuWqymrPERcn+89pcazm0rz3Elcmq8QXTkQcbG7szyINOngqIJ0vV
 jSIXotQ98bO1BeqjrnovSmDs7ARA4ZzBxYlUy79sa9YTtEXGKMN/DT3Co7Y3T4gG28Kq
 20Qw==
X-Gm-Message-State: AOJu0YwWgRZAbsH+OKE9MSg+z0t8T8jFF6vXOGVnZcH0GB5uNEMlbRs7
 /ElR4EpszwBaDPsQCM+/Ojy2PQ==
X-Google-Smtp-Source: AGHT+IFnaOym9nTYI6ng2NrtMTqEBcrPh/487NPmkivqpWWUE8RrbY6XffFxVJrAdztBDTjDij0j0g==
X-Received: by 2002:a05:6a00:1f07:b0:6c4:d58a:9630 with SMTP id
 be7-20020a056a001f0700b006c4d58a9630mr2679258pfb.4.1699945415032; 
 Mon, 13 Nov 2023 23:03:35 -0800 (PST)
Received: from [157.82.201.2] ([157.82.201.2])
 by smtp.gmail.com with ESMTPSA id
 r1-20020aa78441000000b006c0328b2440sm598450pfn.150.2023.11.13.23.03.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 23:03:34 -0800 (PST)
Message-ID: <637b0f33-6b12-4623-b504-d3ea64908813@daynix.com>
Date: Tue, 14 Nov 2023 16:03:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
To: Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
References: <58fb3b75-dd69-4715-a8ec-4c3df3b7e4c5@daynix.com>
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
 <3c8af942-ca7d-4528-975e-2935718a2428@daynix.com>
 <CAOEp5OfXH-1ygYMJxq1phwbOJkkvnwBce=TDVLwjsXG6UgwPGA@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAOEp5OfXH-1ygYMJxq1phwbOJkkvnwBce=TDVLwjsXG6UgwPGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
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

On 2023/11/14 2:26, Yuri Benditovich wrote:
> 
> 
> On Mon, Nov 13, 2023 at 2:44 PM Akihiko Odaki <akihiko.odaki@daynix.com 
> <mailto:akihiko.odaki@daynix.com>> wrote:
> 
>     On 2023/11/13 20:44, Yuri Benditovich wrote:
>      >
>      >
>      > On Sat, Nov 11, 2023 at 5:28 PM Akihiko Odaki
>     <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>
>      > <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>> wrote:
>      >
>      >     On 2023/11/03 22:14, Yuri Benditovich wrote:
>      >      >
>      >      >
>      >      > On Fri, Nov 3, 2023 at 11:55 AM Akihiko Odaki
>      >     <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>
>     <mailto:akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>>
>      >      > <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>
>      >     <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>>> wrote:
>      >      >
>      >      >     On 2023/11/03 18:35, Yuri Benditovich wrote:
>      >      >      >
>      >      >      >
>      >      >      > On Thu, Nov 2, 2023 at 4:56 PM Akihiko Odaki
>      >      >     <akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com> <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>
>      >     <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com> <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>>
>      >      >      > <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>
>      >     <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>
>      >      >     <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>
>      >     <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>>>> wrote:
>      >      >      >
>      >      >      >     On 2023/11/02 19:20, Yuri Benditovich wrote:
>      >      >      >      >
>      >      >      >      >
>      >      >      >      > On Thu, Nov 2, 2023 at 11:33 AM Michael S.
>     Tsirkin
>      >      >      >     <mst@redhat.com <mailto:mst@redhat.com>
>     <mailto:mst@redhat.com <mailto:mst@redhat.com>>
>      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
>     <mailto:mst@redhat.com <mailto:mst@redhat.com>>>
>      >      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
>     <mailto:mst@redhat.com <mailto:mst@redhat.com>>
>      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
>     <mailto:mst@redhat.com <mailto:mst@redhat.com>>>>
>      >      >      >      > <mailto:mst@redhat.com
>     <mailto:mst@redhat.com> <mailto:mst@redhat.com <mailto:mst@redhat.com>>
>      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
>     <mailto:mst@redhat.com <mailto:mst@redhat.com>>>
>      >      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
>     <mailto:mst@redhat.com <mailto:mst@redhat.com>>
>      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
>     <mailto:mst@redhat.com <mailto:mst@redhat.com>>>>>> wrote:
>      >      >      >      >
>      >      >      >      >     On Thu, Nov 02, 2023 at 11:09:27AM
>     +0200, Yuri
>      >      >     Benditovich wrote:
>      >      >      >      >      > Probably we mix two different patches
>     in this
>      >      >     discussion.
>      >      >      >      >      > Focusing on the patch in the e-mail
>     header:
>      >      >      >      >      >
>      >      >      >      >      > IMO it is not acceptable to fail QEMU run
>      >     for one
>      >      >     feature
>      >      >      >     that we
>      >      >      >      >     can't make
>      >      >      >      >      > active when we silently drop all other
>      >     features in
>      >      >     such a
>      >      >      >     case.
>      >      >      >      >
>      >      >      >      >     If the feature is off by default then it
>     seems more
>      >      >     reasonable
>      >      >      >      >     and silent masking can be seen as a bug.
>      >      >      >      >     Most virtio features are on by default
>     this is
>      >     why it's
>      >      >      >      >     reasonable to mask them.
>      >      >      >      >
>      >      >      >      >
>      >      >      >      > If we are talking about RSS: setting it
>     initially
>      >     off is the
>      >      >      >     development
>      >      >      >      > time decision.
>      >      >      >      > When it will be completely stable there is
>     no reason to
>      >      >     keep it
>      >      >      >     off by
>      >      >      >      > default, so this is more a question of time
>     and of a
>      >      >     readiness of
>      >      >      >     libvirt.
>      >      >      >
>      >      >      >     It is not ok to make "on" the default; that will
>      >     enable RSS
>      >      >     even when
>      >      >      >     eBPF steering support is not present and can
>     result in
>      >      >     performance
>      >      >      >     degradation.
>      >      >      >
>      >      >      >
>      >      >      > Exactly as it is today - with vhost=on the host
>     does not
>      >     suggest RSS
>      >      >      > without  eBPF.
>      >      >      > I do not understand what you call "performance
>      >     degradation", can you
>      >      >      > describe the scenario?
>      >      >
>      >      >     I was not clear, but I was talking about the case of
>      >     vhost=off or peers
>      >      >     other than tap (e.g., user). rss=on employs in-qemu RSS,
>      >     which incurs
>      >      >     overheads for such configurations.
>      >      >
>      >      >
>      >      > So, vhost=off OR peers other than tap:
>      >      >
>      >      > In the case of peers other than tap (IMO) we're not
>     talking about
>      >      > performance at all.
>      >      > Backends like "user" (without vnet_hdr) do not support _many_
>      >      > performance-oriented features.
>      >      > If RSS is somehow "supported" for such backends this is
>     rather a
>      >      > misunderstanding (IMO again).
>      >
>      >     We do not need to ensure good performance when RSS is enabled
>     by the
>      >     guest for backends without eBPF steering program as you say.
>     In-QEMU
>      >     RSS
>      >     is only useful for testing and not meant to improve the
>     performance.
>      >
>      >     However, if you set rss=on, QEMU will advertise the
>     availability of RSS
>      >     feature. The guest will have no mean to know if it's
>     implemented in a
>      >     way not performance-wise so it may decide to use the feature
>     to improve
>      >     the performance, which can result in performance degradation.
>      >     Therefore,
>      >     it's better not to set rss=on for such backends.
>      >
>      >
>      > I still do not understand what is the scenario where you see or
>     suspect
>      > the mentioned "performance degradation".
>      > We can discuss whether such a problem exists as soon as you
>     explain it.
> 
>     The scenario is that:
>     - rss=on,
>     - A backend without eBPF steering support is in use, and
>     - The guest expects VIRTIO_NET_F_RSS has little overheads as hardware
>     RSS implementations do.
> 
>     I consider the risk of the performance degradation in such a situation
>     is the reason why virtio-net emits a warning ("Can't load eBPF RSS -
>     fallback to software RSS") when in-QEMU RSS is in use.
> 
> 
> In a described scenario (vhost=off) I do not see why the performance 
> degradation should happen:
> the SW RSS (if activated) will place each packet into proper queue (even 
> if the auto_mq in kernel is not able to do that) and such a way the 
> guest will not need to reschedule the packet to proper CPU
> 

The scenario I'm concerned is that the guest has its own packet steering 
mechanism which is feature-wise superior to RSS. For example, Linux has 
such a mechanism called RPS, which has some advantages due to its 
extensible nature according to:
https://www.kernel.org/doc/html/v6.6/networking/scaling.html#rps-receive-packet-steering

Such a guest may still prefer hardware RSS if available since hardware 
RSS is expected to have less overheads. However, it is not true for 
in-qemu RSS, and using in-QEMU RSS instead of the guest-side steering 
mechanism may just hide useful features the guest-side steering 
mechanism has and result in performance degradation.

Andrew, I appreciate if you also tell the rationale behind the warning 
you put for software RSS ("Can't load eBPF RSS - fallback to software RSS").

