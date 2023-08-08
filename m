Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 029D7774C05
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:02:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTTpa-0004SD-Fo; Tue, 08 Aug 2023 17:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qTTpY-0004Rz-5r
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:01:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qTTpW-0004Wl-Gx
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691528485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KrsZpokEOxo0xRRQpLboOyrlU0Shjv+mCxwffPvGntA=;
 b=F+2SQkDn+m5AM9XIeU6U16QjlV/raF18gqKKKqMiF27/yLEPIgNoQOhmZH98trGKhmvvhA
 iiq93JlZGADgD//LNTJUwxLwrYJrZ1iVaT10krKyw+AeVwYiobeuDHin2kCPqM6EEQlov/
 BD/zAIIjZCV68u2+8tlaJGBzspckeso=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-YtdMatyGNoSESNCVnR_tqA-1; Tue, 08 Aug 2023 17:01:22 -0400
X-MC-Unique: YtdMatyGNoSESNCVnR_tqA-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-56ce4f82d18so718121eaf.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691528481; x=1692133281;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KrsZpokEOxo0xRRQpLboOyrlU0Shjv+mCxwffPvGntA=;
 b=J+cbubOQg4mMSBX+kOzc1hc3MSdTkp3DvcW3TY7jJ7JgdJ0SlHipCgX9RAG6oNzR7s
 intH5BYrZiHqVowYSjR2g3yyNqW3m6Xd+yNH0yGHBKs+EjHMAld04mf2C7UViBfYhM9L
 HxXOewJbH0P0xcxUKQ+wVDuTxzK3zO2NwaAKRuXOg8brYr8ihT8SCM6UokG35blhVtIy
 y8XLTRBLGIX1IsGXUX3zPrgpuPxUrnPMttE96jDnLzL0GmeD1d2BQmI2O1BoXKA28UCh
 S9c/wf/J9zFeyBypUmKFN2tG10kbUQd/n4NuIotfZeUwjXgoiGEm7/t+6WoDTqE6+oyG
 JKsQ==
X-Gm-Message-State: AOJu0YxnJt7NZB0qUSe4HBlydIm6Vsx2SNTBZRzzKcNivPbMK6PkcKAA
 FMbqEnCVuCeZgBWECjz5CYWldUE159Sjaj0ytdRTqCTdV8pihFFAnDtVNd0law1pSZc6r+u+jP/
 FhWCk5wn973y0yVM=
X-Received: by 2002:a05:6359:a21:b0:139:fd45:5db5 with SMTP id
 el33-20020a0563590a2100b00139fd455db5mr490651rwb.1.1691528481659; 
 Tue, 08 Aug 2023 14:01:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBxNr+IuQwnZfbbPyGWmB0OeOXjc0wRnLsE2L3R20OP85wdlexPG+HJiBLaUJUC26sgE7/qA==
X-Received: by 2002:a05:6359:a21:b0:139:fd45:5db5 with SMTP id
 el33-20020a0563590a2100b00139fd455db5mr490633rwb.1.1691528481300; 
 Tue, 08 Aug 2023 14:01:21 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 y5-20020ac81285000000b00405502aaf76sm3620553qti.57.2023.08.08.14.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 14:01:20 -0700 (PDT)
Date: Tue, 8 Aug 2023 17:01:17 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Thiner Logoer <logoerthiner1@163.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
Message-ID: <ZNKtHVotkfgI1tb4@x1n>
References: <20230807190736.572665-1-david@redhat.com>
 <20230807190736.572665-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230807190736.572665-2-david@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Aug 07, 2023 at 09:07:32PM +0200, David Hildenbrand wrote:
> From: Thiner Logoer <logoerthiner1@163.com>
> 
> Users may specify
> * "-mem-path" or
> * "-object memory-backend-file,share=off,readonly=off"
> and expect such COW (MAP_PRIVATE) mappings to work, even if the user
> does not have write permissions to open the file.
> 
> For now, we would always fail in that case, always requiring file write
> permissions. Let's detect when that failure happens and fallback to opening
> the file readonly.
> 
> Warn the user, since there are other use cases where we want the file to
> be mapped writable: ftruncate() and fallocate() will fail if the file
> was not opened with write permissions.
> 
> Signed-off-by: Thiner Logoer <logoerthiner1@163.com>
> Co-developed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  softmmu/physmem.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index 3df73542e1..d1ae694b20 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -1289,8 +1289,7 @@ static int64_t get_file_align(int fd)
>  static int file_ram_open(const char *path,
>                           const char *region_name,
>                           bool readonly,
> -                         bool *created,
> -                         Error **errp)
> +                         bool *created)
>  {
>      char *filename;
>      char *sanitized_name;
> @@ -1334,10 +1333,7 @@ static int file_ram_open(const char *path,
>              g_free(filename);
>          }
>          if (errno != EEXIST && errno != EINTR) {
> -            error_setg_errno(errp, errno,
> -                             "can't open backing store %s for guest RAM",
> -                             path);
> -            return -1;
> +            return -errno;
>          }
>          /*
>           * Try again on EINTR and EEXIST.  The latter happens when
> @@ -1946,9 +1942,23 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
>      bool created;
>      RAMBlock *block;
>  
> -    fd = file_ram_open(mem_path, memory_region_name(mr), readonly, &created,
> -                       errp);
> +    fd = file_ram_open(mem_path, memory_region_name(mr), readonly, &created);
> +    if (fd == -EACCES && !(ram_flags & RAM_SHARED) && !readonly) {
> +        /*
> +         * We can have a writable MAP_PRIVATE mapping of a readonly file.
> +         * However, some operations like ftruncate() or fallocate() might fail
> +         * later, let's warn the user.
> +         */
> +        fd = file_ram_open(mem_path, memory_region_name(mr), true, &created);
> +        if (fd >= 0) {
> +            warn_report("backing store %s for guest RAM (MAP_PRIVATE) opened"
> +                        " readonly because the file is not writable", mem_path);

I can understand the use case, but this will be slightly unwanted,
especially the user doesn't yet have a way to predict when will it happen.

Meanwhile this changes the behavior, is it a concern that someone may want
to rely on current behavior of failing?

To think from a higher level of current use case, the ideal solution seems
to me that if the ram file can be put on a file system that supports CoW
itself (like btrfs), we can snapshot that ram file and make it RW for the
qemu instance. Then here it'll be able to open the file.  We'll be able to
keep the interface working as before, meanwhile it'll work with fallocate
or truncations too I assume.

Would that be better instead of changing QEMU?

Thanks,

> +        }
> +    }
>      if (fd < 0) {
> +        error_setg_errno(errp, -fd,
> +                         "can't open backing store %s for guest RAM",
> +                         mem_path);
>          return NULL;
>      }
>  
> -- 
> 2.41.0
> 

-- 
Peter Xu


