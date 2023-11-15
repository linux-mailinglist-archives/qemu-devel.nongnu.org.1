Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBD07EBCF0
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 07:11:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r395h-0000Ql-Of; Wed, 15 Nov 2023 01:09:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r395e-0000QM-Is
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 01:09:30 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r395b-0002dg-7A
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 01:09:30 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5a9bf4fbd3fso5192507a12.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 22:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700028565; x=1700633365;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WXcnmaGuUlPsci1nsyR4gfbSFL2+eczZ5kaZaZau6Vk=;
 b=Wi5ySPu2RZtupaRWwmkz+k99Q4tqGklq4ZJbpNeg0WBqmtragKRjoXrHz/Wvcx/xZh
 yXL3ZC1bTl5reGvRYk0TBAsebVV6ZFeSGsgx/DPL/GPkHXZ08Gdgw+i7usuXtvVER8o7
 VDCRtmI9dEi3gfPlq07uq4zgkCTxEj2jgvoEHNhsYUFn98lxRSTjHzRTSD+WHukg9Js0
 MHSLTYInrNjIT5TOcSv8c8T7tuVCp/m7++4ccs2JL/Ksk7eD1PgvFu7amzQfLcgiUhDq
 cGHXzU2QETRV9itF62iNv+c74Xf+jipmSZOshEMComodQQseIAxqROyd697m57MZkv4K
 rNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700028565; x=1700633365;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WXcnmaGuUlPsci1nsyR4gfbSFL2+eczZ5kaZaZau6Vk=;
 b=Dq3T/RXQ2Ai/jIwi2iXRz5il+pIEIG3Ai1BuJQ/ku20jPMQ1WKoxOyR3o1cAC2DS7Q
 8PQ1GVeluKVPQdTv4e4uvEfLsFqC+Br9hF3wZfAZhWPmkqowLMOgUTBm7u15CJyh22n2
 8zVgKWhwrB2kCM+D8J3yvB70vRylhR7Pw+DmsKQ8t33HHLKTGBcoLDmfEB47MPX177BW
 vcUGqmyODHcmJNND6rnPnDVEvRMXhkJAqx43K3hx/CTwKiR1flNSIBLKWPBHyy4TnHDl
 DqT+hd7AlvnueM4Az9PwNVv88p75WIbKmRwxLis/3mO86+LJrtBOZ610pDfFQUZpGFoF
 DfAg==
X-Gm-Message-State: AOJu0Yyj5oMCRCH1DT2b8dJXDnGiyKpJfvQz6UrQl6rrVHERGtT1kJGv
 jNh69jrzywnAFuvoviu0LEuOzg==
X-Google-Smtp-Source: AGHT+IGOQBlsSl6o0j3d5do5RwT7DPf/hGbOpT2SPm7tGhVn8XCSDf78H5GzbE/BrboXUMYnpP57wQ==
X-Received: by 2002:a05:6a20:1447:b0:15d:b243:6131 with SMTP id
 a7-20020a056a20144700b0015db2436131mr14476341pzi.44.1700028564472; 
 Tue, 14 Nov 2023 22:09:24 -0800 (PST)
Received: from [157.82.201.2] ([157.82.201.2])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a170903121200b001bf52834696sm6574070plh.207.2023.11.14.22.09.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 22:09:24 -0800 (PST)
Message-ID: <036085f8-7837-4842-bd8b-6c2b4ec560e0@daynix.com>
Date: Wed, 15 Nov 2023 15:09:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
To: Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Andrew Melnychenko <andrew@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
References: <58fb3b75-dd69-4715-a8ec-4c3df3b7e4c5@daynix.com>
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
 <637b0f33-6b12-4623-b504-d3ea64908813@daynix.com>
 <CAOEp5Oc3mb=v-F3Xfx-ypzojq7hLeoPmxu53WA9_4mTx1j50BA@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAOEp5Oc3mb=v-F3Xfx-ypzojq7hLeoPmxu53WA9_4mTx1j50BA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52f.google.com
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



On 2023/11/15 7:09, Yuri Benditovich wrote:
> 
> 
> On Tue, Nov 14, 2023 at 9:03 AM Akihiko Odaki <akihiko.odaki@daynix.com 
> <mailto:akihiko.odaki@daynix.com>> wrote:
> 
>     On 2023/11/14 2:26, Yuri Benditovich wrote:
>      >
>      >
>      > On Mon, Nov 13, 2023 at 2:44 PM Akihiko Odaki
>     <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>
>      > <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>> wrote:
>      >
>      >     On 2023/11/13 20:44, Yuri Benditovich wrote:
>      >      >
>      >      >
>      >      > On Sat, Nov 11, 2023 at 5:28 PM Akihiko Odaki
>      >     <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>
>     <mailto:akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>>
>      >      > <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>
>      >     <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>>> wrote:
>      >      >
>      >      >     On 2023/11/03 22:14, Yuri Benditovich wrote:
>      >      >      >
>      >      >      >
>      >      >      > On Fri, Nov 3, 2023 at 11:55 AM Akihiko Odaki
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
>      >      >      >     On 2023/11/03 18:35, Yuri Benditovich wrote:
>      >      >      >      >
>      >      >      >      >
>      >      >      >      > On Thu, Nov 2, 2023 at 4:56 PM Akihiko Odaki
>      >      >      >     <akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>
>      >     <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>> <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>
>      >     <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>>
>      >      >     <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>
>      >     <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>> <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>
>      >     <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>>>
>      >      >      >      > <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>
>      >     <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>
>      >      >     <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>
>      >     <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>>
>      >      >      >     <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>
>      >     <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>
>      >      >     <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>
>      >     <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>>>>> wrote:
>      >      >      >      >
>      >      >      >      >     On 2023/11/02 19:20, Yuri Benditovich wrote:
>      >      >      >      >      >
>      >      >      >      >      >
>      >      >      >      >      > On Thu, Nov 2, 2023 at 11:33 AM
>     Michael S.
>      >     Tsirkin
>      >      >      >      >     <mst@redhat.com <mailto:mst@redhat.com>
>     <mailto:mst@redhat.com <mailto:mst@redhat.com>>
>      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
>     <mailto:mst@redhat.com <mailto:mst@redhat.com>>>
>      >      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
>     <mailto:mst@redhat.com <mailto:mst@redhat.com>>
>      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
>     <mailto:mst@redhat.com <mailto:mst@redhat.com>>>>
>      >      >      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
>     <mailto:mst@redhat.com <mailto:mst@redhat.com>>
>      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
>     <mailto:mst@redhat.com <mailto:mst@redhat.com>>>
>      >      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
>     <mailto:mst@redhat.com <mailto:mst@redhat.com>>
>      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
>     <mailto:mst@redhat.com <mailto:mst@redhat.com>>>>>
>      >      >      >      >      > <mailto:mst@redhat.com
>     <mailto:mst@redhat.com>
>      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>>
>     <mailto:mst@redhat.com <mailto:mst@redhat.com>
>     <mailto:mst@redhat.com <mailto:mst@redhat.com>>>
>      >      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
>     <mailto:mst@redhat.com <mailto:mst@redhat.com>>
>      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
>     <mailto:mst@redhat.com <mailto:mst@redhat.com>>>>
>      >      >      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
>     <mailto:mst@redhat.com <mailto:mst@redhat.com>>
>      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
>     <mailto:mst@redhat.com <mailto:mst@redhat.com>>>
>      >      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
>     <mailto:mst@redhat.com <mailto:mst@redhat.com>>
>      >     <mailto:mst@redhat.com <mailto:mst@redhat.com>
>     <mailto:mst@redhat.com <mailto:mst@redhat.com>>>>>>> wrote:
>      >      >      >      >      >
>      >      >      >      >      >     On Thu, Nov 02, 2023 at 11:09:27AM
>      >     +0200, Yuri
>      >      >      >     Benditovich wrote:
>      >      >      >      >      >      > Probably we mix two different
>     patches
>      >     in this
>      >      >      >     discussion.
>      >      >      >      >      >      > Focusing on the patch in the
>     e-mail
>      >     header:
>      >      >      >      >      >      >
>      >      >      >      >      >      > IMO it is not acceptable to
>     fail QEMU run
>      >      >     for one
>      >      >      >     feature
>      >      >      >      >     that we
>      >      >      >      >      >     can't make
>      >      >      >      >      >      > active when we silently drop
>     all other
>      >      >     features in
>      >      >      >     such a
>      >      >      >      >     case.
>      >      >      >      >      >
>      >      >      >      >      >     If the feature is off by default
>     then it
>      >     seems more
>      >      >      >     reasonable
>      >      >      >      >      >     and silent masking can be seen as
>     a bug.
>      >      >      >      >      >     Most virtio features are on by
>     default
>      >     this is
>      >      >     why it's
>      >      >      >      >      >     reasonable to mask them.
>      >      >      >      >      >
>      >      >      >      >      >
>      >      >      >      >      > If we are talking about RSS: setting it
>      >     initially
>      >      >     off is the
>      >      >      >      >     development
>      >      >      >      >      > time decision.
>      >      >      >      >      > When it will be completely stable
>     there is
>      >     no reason to
>      >      >      >     keep it
>      >      >      >      >     off by
>      >      >      >      >      > default, so this is more a question
>     of time
>      >     and of a
>      >      >      >     readiness of
>      >      >      >      >     libvirt.
>      >      >      >      >
>      >      >      >      >     It is not ok to make "on" the default;
>     that will
>      >      >     enable RSS
>      >      >      >     even when
>      >      >      >      >     eBPF steering support is not present and can
>      >     result in
>      >      >      >     performance
>      >      >      >      >     degradation.
>      >      >      >      >
>      >      >      >      >
>      >      >      >      > Exactly as it is today - with vhost=on the host
>      >     does not
>      >      >     suggest RSS
>      >      >      >      > without  eBPF.
>      >      >      >      > I do not understand what you call "performance
>      >      >     degradation", can you
>      >      >      >      > describe the scenario?
>      >      >      >
>      >      >      >     I was not clear, but I was talking about the
>     case of
>      >      >     vhost=off or peers
>      >      >      >     other than tap (e.g., user). rss=on employs
>     in-qemu RSS,
>      >      >     which incurs
>      >      >      >     overheads for such configurations.
>      >      >      >
>      >      >      >
>      >      >      > So, vhost=off OR peers other than tap:
>      >      >      >
>      >      >      > In the case of peers other than tap (IMO) we're not
>      >     talking about
>      >      >      > performance at all.
>      >      >      > Backends like "user" (without vnet_hdr) do not
>     support _many_
>      >      >      > performance-oriented features.
>      >      >      > If RSS is somehow "supported" for such backends this is
>      >     rather a
>      >      >      > misunderstanding (IMO again).
>      >      >
>      >      >     We do not need to ensure good performance when RSS is
>     enabled
>      >     by the
>      >      >     guest for backends without eBPF steering program as
>     you say.
>      >     In-QEMU
>      >      >     RSS
>      >      >     is only useful for testing and not meant to improve the
>      >     performance.
>      >      >
>      >      >     However, if you set rss=on, QEMU will advertise the
>      >     availability of RSS
>      >      >     feature. The guest will have no mean to know if it's
>      >     implemented in a
>      >      >     way not performance-wise so it may decide to use the
>     feature
>      >     to improve
>      >      >     the performance, which can result in performance
>     degradation.
>      >      >     Therefore,
>      >      >     it's better not to set rss=on for such backends.
>      >      >
>      >      >
>      >      > I still do not understand what is the scenario where you
>     see or
>      >     suspect
>      >      > the mentioned "performance degradation".
>      >      > We can discuss whether such a problem exists as soon as you
>      >     explain it.
>      >
>      >     The scenario is that:
>      >     - rss=on,
>      >     - A backend without eBPF steering support is in use, and
>      >     - The guest expects VIRTIO_NET_F_RSS has little overheads as
>     hardware
>      >     RSS implementations do.
>      >
>      >     I consider the risk of the performance degradation in such a
>     situation
>      >     is the reason why virtio-net emits a warning ("Can't load
>     eBPF RSS -
>      >     fallback to software RSS") when in-QEMU RSS is in use.
>      >
>      >
>      > In a described scenario (vhost=off) I do not see why the performance
>      > degradation should happen:
>      > the SW RSS (if activated) will place each packet into proper
>     queue (even
>      > if the auto_mq in kernel is not able to do that) and such a way the
>      > guest will not need to reschedule the packet to proper CPU
>      >
> 
>     The scenario I'm concerned is that the guest has its own packet
>     steering
>     mechanism which is feature-wise superior to RSS. For example, Linux has
>     such a mechanism called RPS, which has some advantages due to its
>     extensible nature according to:
>     https://www.kernel.org/doc/html/v6.6/networking/scaling.html#rps-receive-packet-steering <https://www.kernel.org/doc/html/v6.6/networking/scaling.html#rps-receive-packet-steering>
> 
>     Such a guest may still prefer hardware RSS if available since hardware
>     RSS is expected to have less overheads. However, it is not true for
>     in-qemu RSS, and using in-QEMU RSS instead of the guest-side steering
>     mechanism may just hide useful features the guest-side steering
>     mechanism has and result in performance degradation.
> 
> 
> Note that in terms of per-packet computation for RSS the in-QEMU RSS 
> does exactly the same operations in native code that the eBPF does in 
> the emulation.
> So, I wouldn't say that SW RSS brings some "performance degradation".
> We prefer eBPF as it can serve both vhost and non-vhost setups.

I see the eBPF steering program in a different way.

tuntap can have several queues, and the assignment of packets is 
automatically done by tuntap by default. However, the default assignment 
policy may not be good for all applications, and some may need a 
different policy. Such an application can still re-assign packets to 
application-internal queues that reside on different CPUs and that's 
what 'in-qemu' RSS does. However, that incurs communication overheads 
across CPUs. The eBPF steering program can eliminate the overheads by 
allowing the userspace to override the packet assignment policy with eBPF.

The eBPF steering program feature of tuntap and its benefit are 
independent of the vhost usage. In fact, the feature predates the usage 
in QEMU that combines vhost and eBPF steering program. The initial 
proposal of the eBPF steering program I found is submitted by Jason and 
available at:
https://lore.kernel.org/lkml/1506500637-13881-1-git-send-email-jasowang@redhat.com/

Jason, please point out if you find something wrong in my understanding 
with the eBPF steering program feature or something to add.

