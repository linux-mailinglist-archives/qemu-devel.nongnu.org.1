Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AB87BD4A6
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 09:51:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpl1w-0008JR-GC; Mon, 09 Oct 2023 03:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qpl1u-0008JF-ID
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 03:50:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qpl1o-0000n0-QT
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 03:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696837811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E250/fwGkAG2JroWI0zpyyjXnY+04kK6EaQhRiw0jZY=;
 b=AjrRRqDRxOvQ2lqUeqcwFimh2ILy6XH0N8KfD9FraAOLCqAuM9c9X2XoEJo/a8kBcZhOMm
 RwqTGVUASUE6rBHMf1lWALHz/2+HMRIatVBItPiw3A8srFUGnEMBOWFiD3hNaHR36tk1TI
 VWaUs8usRW+iE63q9cE1b7dZAcbE4L0=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-JyLDAVTDPgaOewRMC05Jfw-1; Mon, 09 Oct 2023 03:50:09 -0400
X-MC-Unique: JyLDAVTDPgaOewRMC05Jfw-1
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-49a90eb1396so2072038e0c.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 00:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696837809; x=1697442609;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E250/fwGkAG2JroWI0zpyyjXnY+04kK6EaQhRiw0jZY=;
 b=j72RMO/GZ07WoYVM1fRLXUOxvFIWp7loMDZeCOVb59YzbgtYmWyGGYWi0AzX9p9L6r
 7aWCy1hajsyedsTV9QPrf4nztfGfMaUNvtQuDcIIz7qcTS5yh1gqsBwVRCBdsEUzVJ/0
 /Rnt/tOlLUBOyKmmT+ul6DNmxSU5NvMTJ9IugoCAZ+Z+9b0T6lMR8Cr1TOUQL1y/g5C8
 Sv9SGJkCWwTVgmPuYQX7TiY+gqmIopnlgjbo+BbSECXypVOr/0+H+T6r88fYWNtLVCK/
 YD3MuS0xunxB7yVqXEfY8C2gP/FxNIGLyEvf3Irb6rUZtfcRSQcLCy6Qb8ENJsypuF9i
 VanA==
X-Gm-Message-State: AOJu0Yxz9jg4ddxO1Utw2zkAE8deImOGA5SEzNOfd4CdVBaVIhxr0uIb
 Ywf5wvITOMt8crwNKyn9spBBEKuZvpjt93irCYwLmbVQ1uTwMWUOgfgVvfT6nzOztevPS7V0SCm
 /NF0unv/sVwvfViE=
X-Received: by 2002:a1f:cb45:0:b0:49a:b737:4dfa with SMTP id
 b66-20020a1fcb45000000b0049ab7374dfamr9713949vkg.4.1696837809131; 
 Mon, 09 Oct 2023 00:50:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiLcUt4FZiV10h4MfuMNtmK+df0Zea2zKzTEGqtPhx2NBCZ0iZMGQ13l4MlyB99Ocvgl7fdw==
X-Received: by 2002:a1f:cb45:0:b0:49a:b737:4dfa with SMTP id
 b66-20020a1fcb45000000b0049ab7374dfamr9713932vkg.4.1696837808799; 
 Mon, 09 Oct 2023 00:50:08 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-27.web.vodafone.de.
 [109.43.176.27]) by smtp.gmail.com with ESMTPSA id
 t10-20020a0ca68a000000b00668eb252523sm3634878qva.63.2023.10.09.00.50.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 00:50:08 -0700 (PDT)
Message-ID: <d628587a-8b21-7ca8-111e-9603e860c3c6@redhat.com>
Date: Mon, 9 Oct 2023 09:50:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [v3] Help wanted for enabling -Wshadow=local
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <87mswvg683.fsf@pond.sub.org>
 <12397ede-8e20-cb55-b759-d2fbf7732f46@redhat.com>
 <884f4d8c-4ee4-3ee2-ff62-5d7166a75adb@redhat.com>
 <CANCZdfpU1eCM0fatVBuQJW9bLzTZfvp3HNQ=2Kfz9ni90PbmEg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <CANCZdfpU1eCM0fatVBuQJW9bLzTZfvp3HNQ=2Kfz9ni90PbmEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.818, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 06/10/2023 21.08, Warner Losh wrote:
> 
> 
> On Fri, Oct 6, 2023, 11:55 AM Thomas Huth <thuth@redhat.com 
> <mailto:thuth@redhat.com>> wrote:
> 
>     On 06/10/2023 18.18, Thomas Huth wrote:
>      > On 06/10/2023 16.45, Markus Armbruster wrote:
>      >> Local variables shadowing other local variables or parameters make the
>      >> code needlessly hard to understand.  Bugs love to hide in such code.
>      >> Evidence: "[PATCH v3 1/7] migration/rdma: Fix save_page method to fail
>      >> on polling error".
>      >>
>      >> Enabling -Wshadow would prevent bugs like this one.  But we have to
>      >> clean up all the offenders first.
>      >>
>      >> Quite a few people responded to my calls for help.  Thank you so much!
>      >>
>      >> I'm collecting patches in my git repo at
>      >> https://repo.or.cz/qemu/armbru.git
>     <https://repo.or.cz/qemu/armbru.git> in branch shadow-next.  All but the
>      >> last two are in a pending pull request.
>      >>
>      >> My test build is down to seven files with warnings.  "[PATCH v2 0/3]
>      >> hexagon: GETPC() and shadowing fixes" takes care of four, but it needs a
>      >> rebase.
>      >>
>      >> Remaining three:
>      >>
>      >>      In file included from ../hw/display/virtio-gpu-virgl.c:19:
>      >>      ../hw/display/virtio-gpu-virgl.c: In function
>     ‘virgl_cmd_submit_3d’:
>      >>      /work/armbru/qemu/include/hw/virtio/virtio-gpu.h:228:16: warning:
>      >> declaration of ‘s’ shadows a previous local [-Wshadow=compatible-local]
>      >>        228 |         size_t
>      >> s;                                                       \
>      >>            |                ^
>      >>      ../hw/display/virtio-gpu-virgl.c:215:5: note: in expansion of
>     macro
>      >> ‘VIRTIO_GPU_FILL_CMD’
>      >>        215 |     VIRTIO_GPU_FILL_CMD(cs);
>      >>            |     ^~~~~~~~~~~~~~~~~~~
>      >>      ../hw/display/virtio-gpu-virgl.c:213:12: note: shadowed
>     declaration
>      >> is here
>      >>        213 |     size_t s;
>      >>            |            ^
>      >>
>      >>      In file included from ../contrib/vhost-user-gpu/virgl.h:18,
>      >>                       from ../contrib/vhost-user-gpu/virgl.c:17:
>      >>      ../contrib/vhost-user-gpu/virgl.c: In function
>     ‘virgl_cmd_submit_3d’:
>      >>      ../contrib/vhost-user-gpu/vugpu.h:167:16: warning: declaration
>     of ‘s’
>      >> shadows a previous local [-Wshadow=compatible-local]
>      >>        167 |         size_t
>      >> s;                                               \
>      >>            |                ^
>      >>      ../contrib/vhost-user-gpu/virgl.c:203:5: note: in expansion of
>     macro
>      >> ‘VUGPU_FILL_CMD’
>      >>        203 |     VUGPU_FILL_CMD(cs);
>      >>            |     ^~~~~~~~~~~~~~
>      >>      ../contrib/vhost-user-gpu/virgl.c:201:12: note: shadowed
>     declaration
>      >> is here
>      >>        201 |     size_t s;
>      >>            |            ^
>      >>
>      >>      ../contrib/vhost-user-gpu/vhost-user-gpu.c: In function
>      >> ‘vg_resource_flush’:
>      >>      ../contrib/vhost-user-gpu/vhost-user-gpu.c:837:29: warning:
>      >> declaration of ‘i’ shadows a previous local [-Wshadow=local]
>      >>        837 |             pixman_image_t *i =
>      >>            |                             ^
>      >>      ../contrib/vhost-user-gpu/vhost-user-gpu.c:757:9: note: shadowed
>      >> declaration is here
>      >>        757 |     int i;
>      >>            |         ^
>      >>
>      >> Gerd, Marc-André, or anybody else?
>      >>
>      >> More warnings may lurk in code my test build doesn't compile.  Need a
>      >> full CI build with -Wshadow=local to find them.  Anybody care to kick
>      >> one off?
>      >
>      > I ran a build here (with -Werror enabled, so that it's easier to see
>     where
>      > it breaks):
>      >
>      > https://gitlab.com/thuth/qemu/-/pipelines/1028023489
>     <https://gitlab.com/thuth/qemu/-/pipelines/1028023489>
>      >
>      > ... but I didn't see any additional spots in the logs beside the ones
>     that
>      > you already listed.
> 
>     After adding two more patches to fix the above warnings, things look pretty
>     good:
> 
>     https://gitlab.com/thuth/qemu/-/pipelines/1028413030
>     <https://gitlab.com/thuth/qemu/-/pipelines/1028413030>
> 
>     There are just some warnings left in the BSD code, as Warner already
>     mentioned in his reply to v2 of your mail:
> 
>     https://gitlab.com/thuth/qemu/-/jobs/5241420713
>     <https://gitlab.com/thuth/qemu/-/jobs/5241420713>
> 
> 
> I think I have fixes for these. I need to merge what just landed into 
> bsd-user fork, rebase, test, the apply them to qemu master branch, retest 
> and send them off...
> 
> My illness has hung on longer than I thought so I'm still behind...

Get well soon again! ... and no worries about the -Wshadow=local patches in 
the BSD code, there is no hurry - The BSDs are using Clang by default, so 
that option won't get enabled by default there anyway yet - I had to switch 
to GCC in the CI pipeline to trigger those, and I guess only very few people 
will use GCC to compile QEMU on FreeBSD.

  Thomas


