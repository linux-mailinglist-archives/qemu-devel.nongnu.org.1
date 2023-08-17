Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7710777F96E
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 16:42:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWeBd-00025h-JO; Thu, 17 Aug 2023 10:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qWeBb-00024U-48
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 10:41:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qWeBY-0003T7-Eg
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 10:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692283275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=emrF7d3WuaRlbza6Jy3klz2J7Swh5YA7rem+TjlyDoA=;
 b=Nw6+GpGBhQCNP7g4uF+lmgqfFW1AadTvHhZuLipH85ZTkmsO37hzfj3eD3U+FBnPAZ7iCZ
 kLFeOn5p6fLcW95tcETRI3JSfSFA5hebwVb24q2C/lfcFEk2ZhhurGzdq8pBDMmpfuDrHb
 wVhAdSD6ERKrl+cowoZIPXL/js4RT5g=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-vBiWPEARMsOQMN2GpMz_xw-1; Thu, 17 Aug 2023 10:41:13 -0400
X-MC-Unique: vBiWPEARMsOQMN2GpMz_xw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-76cde638658so260948385a.1
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 07:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692283273; x=1692888073;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=emrF7d3WuaRlbza6Jy3klz2J7Swh5YA7rem+TjlyDoA=;
 b=Eii+S3jATkCrU78PBaYyizFORjkLBpgvaKIEWsOT6NzGyjdKhWVLGtvQDfXfvvnmHn
 Ie+TIT27ZagaRgqqSoCnAO2/Z0zZRbrFLK8AE/8CNXciJJS9tgkDM1qtdOf8nMoWmh5+
 CB65CkJBkY63tLwGMKkI2v1g3ulKpMBLUP7sJSoypcmgXPpeZrfVa1c2NRC2HqXT9dha
 CMl1PdqCPgCfoB1yum2Mhs1STpw4fc3zNFEOyWbpZjptuqbhEaHLOJ9HZINaq7ldkNxk
 8r4TU6wy2uOzx5jOfbqDASKc9gByMGHa0a6FB0m/wMW7KsBqctxUSEEnRD3T+Orrjt5i
 5kkQ==
X-Gm-Message-State: AOJu0Yx1RaGrtGUGlxz3PhbahSCeeaUDAsc0pbwgSKRPdtgmXmNBVXzg
 xGaak0fYNix+Z1WXgR8wAKkBsOfAwge1Jxb62FNArKsWY3VrCs05oEScs0K6sg0oX0g9I0FhpGA
 B8PLbhVltxLCRRWM=
X-Received: by 2002:a05:6214:519d:b0:63f:821d:3eb7 with SMTP id
 kl29-20020a056214519d00b0063f821d3eb7mr6473498qvb.6.1692283272905; 
 Thu, 17 Aug 2023 07:41:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmFMe0zZMpRFdLzprZUuXhgeI6iXtQP9aMx6wcY0xKlhlMqknkDz3mvZ2MGQmt2n6vhQ870Q==
X-Received: by 2002:a05:6214:519d:b0:63f:821d:3eb7 with SMTP id
 kl29-20020a056214519d00b0063f821d3eb7mr6473475qvb.6.1692283272555; 
 Thu, 17 Aug 2023 07:41:12 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 i8-20020a0c9c88000000b0063d7740b5d2sm5800248qvf.46.2023.08.17.07.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 07:41:11 -0700 (PDT)
Date: Thu, 17 Aug 2023 10:41:10 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: ThinerLogoer <logoerthiner1@163.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
Message-ID: <ZN4xhh9FXLIRFeHF@x1n>
References: <ZNKtHVotkfgI1tb4@x1n>
 <1d1a7d8f-6260-5905-57ea-514b762ce869@redhat.com>
 <ZNOti1OKN79t68jP@x1n>
 <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
 <6152f171.6a4c.189e069baf7.Coremail.logoerthiner1@163.com>
 <ZNVVmxuQAsSEHqZq@x1n>
 <1b4168d2.4182.189e324e0ef.Coremail.logoerthiner1@163.com>
 <08cc9db9-b774-b027-58f5-dd7e6c374657@redhat.com>
 <2b967b3.13b7.189e82ee694.Coremail.logoerthiner1@163.com>
 <06f9a805-8150-8106-7d0a-05d0d2465cd0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <06f9a805-8150-8106-7d0a-05d0d2465cd0@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 17, 2023 at 11:07:23AM +0200, David Hildenbrand wrote:
> @Stefan, see below on a R/O NVDIMM question.
> 
> We're discussing how to get MAPR_PRIVATE R/W mapping of a
> memory-backend-file running when using R/O files.
> 
> > 
> > This seems a good idea. I am good with the solution you proposed
> > here as well.
> 
> I was just going to get started working on that, when I realized
> something important:
> 
> 
> "@readonly: if true, the backing file is opened read-only; if false,
>  it is opened read-write.  (default: false)"
> 
> "@share: if false, the memory is private to QEMU; if true, it is
>  shared (default: false)"
> 
> So readonly is *all* about the file access mode already ... the mmap()
> parameters are just a side-effect of that. Adding a new
> "file-access-mode" or similar would be wrong.

Not exactly a side effect, IMHO.  IIUC it's simply because we didn't have a
need of using different perm for memory/file levels.  See the other patch
commit message from Stefan:

https://lore.kernel.org/all/20210104171320.575838-2-stefanha@redhat.com/

    There is currently no way to open(O_RDONLY) and mmap(PROT_READ) when
    [...]

So the goal at that time was to map/open both in RO mode, afaiu.  So one
parameter was enough at that time.  It doesn't necessarily must be for only
the file permission or memory, while in reality/code it does apply to both
for now until we see a need on differentiating them for CoW purpose.

> 
> 
> Here are the combinations we have right now:
> 
> -object memory-backend-file,share=on,readonly=on
> 
>  -> Existing behavior: Open readonly, mmap readonly shared
>  -> Makes sense, mmap'ing readwrite would fail
> 
> -object memory-backend-file,share=on,readonly=off
> 
>  -> Existing behavior: Open readwrite, mmap readwrite shared
>  -> Mostly makes sense: why open a shared file R/W and not mmap it
>     R/W?
> 
> -object memory-backend-file,share=off,readonly=off
>  -> Existing behavior: Open readwrite, mmap readwrite private
>  -> Mostly makes sense: why open a file R/W and not map it R/W (even if
>     private)?
> 
> -object memory-backend-file,share=off,readonly=on
>  -> Existing behavior: Open readonly, mmap readonly private
>  -> That's the problematic one
> 
> 
> So for your use case (VM templating using a readonly file), you
> would actually want to use:
> 
> -object memory-backend-file,share=off,readonly=on
> 
> BUT, have the mmap be writable (instead of currently readonly).
> 
> Assuming we would change the current behavior, what if someone would
> specify:
> 
> -object memory-backend-file,readonly=on
> 
> (because the default is share=off ...) and using it for a R/O NVDIMM,
> where we expect any write access to fail.

It will (as expected), right?  fallocate() will just fail on the RO files.

To be explicit, maybe we should just remember the readonly attribute for a
ramblock and then we can even provide a more meaningful error log, like:

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 3df73542e1..f8c11c8d54 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -3424,9 +3424,13 @@ int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque)
 int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
 {
     int ret = -1;
-
     uint8_t *host_startaddr = rb->host + start;
 
+    if (rb->flags & RAM_READONLY) {
+        // more meaningful error reports (though right now no errp passed in..)
+        return -EACCES;
+    }
+

I see that Stefan even raised this question in the commit log:

    No new RAMBlock flag is introduced for read-only because it's unclear
    whether RAMBlocks need to know that they are read-only. Pass a bool
    readonly argument instead.

Right now failing at fallocate() isn't that bad to me.

> 
> 
> But let's look at the commit that added the "readonly" parameter:
> 
> commit 86635aa4e9d627d5142b81c57a33dd1f36627d07
> Author: Stefan Hajnoczi <stefanha@redhat.com>
> Date:   Mon Jan 4 17:13:19 2021 +0000
> 
>     hostmem-file: add readonly=on|off option
>     Let -object memory-backend-file work on read-only files when the
>     readonly=on option is given. This can be used to share the contents of a
>     file between multiple guests while preventing them from consuming
>     Copy-on-Write memory if guests dirty the pages, for example.
> 
> That was part of
> 
> https://lore.kernel.org/all/20210104171320.575838-3-stefanha@redhat.com/T/#m712f995e6dcfdde433958bae5095b145dd0ee640
> 
> From what I understand, for NVDIMMs we always use
> "-object memory-backend-file,share=on", even when we want a
> readonly NVDIMM.
> 
> 
> So we have two options:
> 
> 1) Change the current behavior of -object memory-backend-file,share=off,readonly=on:
> 
> -> Open the file r/o but mmap it writable
> 
> 2) Add a new property to configure the mmap accessibility. Not a big fan of that.
> 
> 
> @Stefan, do you have any concern when we would do 1) ?
> 
> As far as I can tell, we have to set the nvdimm to "unarmed=on" either way:
> 
> +   "unarmed" controls the ACPI NFIT NVDIMM Region Mapping Structure "NVDIMM
> +   State Flags" Bit 3 indicating that the device is "unarmed" and cannot accept
> +   persistent writes. Linux guest drivers set the device to read-only when this
> +   bit is present. Set unarmed to on when the memdev has readonly=on.
> 
> So changing the behavior would not really break the nvdimm use case.
> 
> Further, we could warn in nvdimm code when we stumble over this configuration with
> unarmed=on.

I'll leave nvdimm specific question to Stefan, but isn't this also will map
any readonly=on memory backends (besides nvdimm) to have the memory
writable, which is still unexpected?

-- 
Peter Xu


