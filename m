Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CCC7A8AFA
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 19:56:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj1QM-0008M9-BE; Wed, 20 Sep 2023 13:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qj1QI-0008LP-M8; Wed, 20 Sep 2023 13:55:39 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qj1QG-00052A-PF; Wed, 20 Sep 2023 13:55:38 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-57b41950b4eso77555eaf.2; 
 Wed, 20 Sep 2023 10:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695232534; x=1695837334; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oCK+iZwDxCa2iC15R/7mlsFyjshczXwX+bxoKIrGI+4=;
 b=Oeg3OrBATWieo+jtLfToU26ZzK+yglrTbWk6dpt93RGde65aR1/yW4fyaP1+1MXtJC
 ch7z9dfLVOUgfrB8XO1VWn1qtLUq5+zCZk/u9OZhDgSznQC4IVnkGsPGz63528axiYmY
 6nY5fkuGIjKXVgBvD6kIhUJM0rlR90r5+K65IWTglLwEGcwleafWzE6r83idcJuChmCL
 R9NRl5nHHecRGBUDSIKe/dO7onNqKwUS0q8oPXWFsG1532aMMi5Vr2rBZU8xR5dnnqgf
 3MVp0o1oJt/UjK9sHHYvllrOuYsKPdLRm9NhUh6QDFvLil+YNLVgZ9nufIeRRvLyRs/E
 JA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695232534; x=1695837334;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oCK+iZwDxCa2iC15R/7mlsFyjshczXwX+bxoKIrGI+4=;
 b=FhrrY3rUW52s3uUNHPSHGyIUF8529a/OmSnepUMHFtPKWF4q/yQS0jkY/u2+5qU0Nz
 D8s+5zEnWjyJk6Vso7ZvowXcEAgXlvEAauyYbdGgNQ/BzF6Kl9GKz+TAnq1lyE0OTwDO
 9lnSu6yzKdpi6S8NOOyEHn3TvCWNaD8Xu41U/tUrKvQr24GvkSTf0Uiy0TJ1JR7EFIrA
 60oXcBgmbtako7KrJkF7GuPaiqlXhBXZvdNvWv2HkugRSFA2VTVYdK6g/olPP2zlFurJ
 f/aPt+LM+m5ow7HRJ4C4p93jIrtTEMIFemiAF/iMa6TkFdNADzCf6VqIkf49oTVPtU6G
 205w==
X-Gm-Message-State: AOJu0Yxp51sYn34itvqRhuRRzbcTuD1fkVBa5OOZ15Amhl2Ysv3MqNPg
 P6/UZlzLg99UYY/A/CPA10m++x1maxJHRC3j/yks+aRTUNo=
X-Google-Smtp-Source: AGHT+IGREXuouBPo4OkvPIxLakl11Xi7C1qlcygYR3pA8KGtoo2ObT/k571VdcDgxl8RXD/HnA89fpmOuKelyNd7MkM=
X-Received: by 2002:a4a:624d:0:b0:573:61a5:5f71 with SMTP id
 y13-20020a4a624d000000b0057361a55f71mr3539694oog.5.1695232533735; Wed, 20 Sep
 2023 10:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230920092108.258898-1-den@openvz.org>
In-Reply-To: <20230920092108.258898-1-den@openvz.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 20 Sep 2023 13:55:21 -0400
Message-ID: <CAJSP0QWXi0pGy7NKq42u3-=3GPP6kFnz6TA7HaBs8ZBXjKLidg@mail.gmail.com>
Subject: Re: [PULL 00/22] implement discard operation for Parallels images
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, 20 Sept 2023 at 05:22, Denis V. Lunev <den@openvz.org> wrote:
>
> The following changes since commit 4907644841e3200aea6475c0f72d3d987e9f3d93:
>
>   Merge tag 'mem-2023-09-19' of https://github.com/davidhildenbrand/qemu into staging (2023-09-19 13:22:19 -0400)
>
> are available in the Git repository at:
>
>   https://src.openvz.org/scm/~den/qemu.git tags/pull-parallels-2023-09-20

Hi Denis,
Please take a look at the following CI failure. I have dropped this
series for now.

clang -m64 -mcx16 -Ilibblock.fa.p -I. -I.. -Iqapi -Itrace -Iui
-Iui/shader -Iblock -I/usr/include/p11-kit-1 -I/usr/include/uuid
-I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include
-I/usr/include/sysprof-4 -flto -fcolor-diagnostics -Wall -Winvalid-pch
-Werror -std=gnu11 -O2 -g -fstack-protector-strong
-fsanitize=safe-stack -Wundef -Wwrite-strings -Wmissing-prototypes
-Wstrict-prototypes -Wredundant-decls -Wold-style-definition
-Wtype-limits -Wformat-security -Wformat-y2k -Winit-self
-Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-labels
-Wexpansion-to-defined -Wmissing-format-attribute
-Wno-initializer-overrides -Wno-missing-include-dirs
-Wno-shift-negative-value -Wno-string-plus-int
-Wno-typedef-redefinition -Wno-tautological-type-limit-compare
-Wno-psabi -Wno-gnu-variable-sized-type-not-at-end -Wthread-safety
-isystem /builds/qemu-project/qemu/linux-headers -isystem
linux-headers -iquote . -iquote /builds/qemu-project/qemu -iquote
/builds/qemu-project/qemu/include -iquote
/builds/qemu-project/qemu/host/include/x86_64 -iquote
/builds/qemu-project/qemu/host/include/generic -iquote
/builds/qemu-project/qemu/tcg/i386 -pthread -D_GNU_SOURCE
-D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv
-fsanitize=cfi-icall -fsanitize-cfi-icall-generalize-pointers
-fno-sanitize-trap=cfi-icall -fPIE -D_FILE_OFFSET_BITS=64
-D__USE_FILE_OFFSET64 -D__USE_LARGEFILE64 -DUSE_POSIX_ACLS=1 -MD -MQ
libblock.fa.p/block_parallels.c.o -MF
libblock.fa.p/block_parallels.c.o.d -o
libblock.fa.p/block_parallels.c.o -c ../block/parallels.c
../block/parallels.c:210:21: error: calling function
'bdrv_co_getlength' requires holding mutex 'graph_lock'
[-Werror,-Wthread-safety-analysis]
payload_bytes = bdrv_co_getlength(bs->file->bs);
^
../block/parallels.c:572:15: error: calling function
'bdrv_co_pdiscard' requires holding mutex 'graph_lock'
[-Werror,-Wthread-safety-analysis]
ret = bdrv_co_pdiscard(bs->file, host_off, s->cluster_size);
^
2 errors generated.

https://gitlab.com/qemu-project/qemu/-/jobs/5131277794

Stefan

>
> for you to fetch changes up to ead1064587ba6534aa2c3da6383713a009dafcb1:
>
>   tests: extend test 131 to cover availability of the write-zeroes (2023-09-20 10:14:15 +0200)
>
> ----------------------------------------------------------------
> Parallels format driver:
> * regular calculation of cluster used bitmap of the image file
> * cluster allocation on the base of that bitmap (effectively allocation of
>   new clusters could be done inside the image if that offset space is unused)
> * support of DISCARD and WRITE_ZEROES operations
> * image check bugfixes
> * unit tests fixes
> * unit tests covering new functionality
>
> ----------------------------------------------------------------
> Denis V. Lunev (22):
>       parallels: fix formatting in bdrv_parallels initialization
>       parallels: mark driver as supporting CBT
>       parallels: fix memory leak in parallels_open()
>       parallels: invent parallels_opts_prealloc() helper to parse prealloc opts
>       parallels: return earler in fail_format branch in parallels_open()
>       parallels: return earlier from parallels_open() function on error
>       parallels: refactor path when we need to re-check image in parallels_open
>       parallels: create mark_used() helper which sets bit in used bitmap
>       tests: ensure that image validation will not cure the corruption
>       parallels: fix broken parallels_check_data_off()
>       parallels: add test which will validate data_off fixes through repair
>       parallels: collect bitmap of used clusters at open
>       tests: fix broken deduplication check in parallels format test
>       tests: test self-cure of parallels image with duplicated clusters
>       parallels: accept multiple clusters in mark_used()
>       parallels: update used bitmap in allocate_cluster
>       parallels: naive implementation of allocate_clusters with used bitmap
>       parallels: improve readability of allocate_clusters
>       parallels: naive implementation of parallels_co_pdiscard
>       tests: extend test 131 to cover availability of the discard operation
>       parallels: naive implementation of parallels_co_pwrite_zeroes
>       tests: extend test 131 to cover availability of the write-zeroes
>
>  block/parallels.c                             | 389 ++++++++++++++++++++------
>  block/parallels.h                             |   3 +
>  tests/qemu-iotests/131                        |  52 ++++
>  tests/qemu-iotests/131.out                    |  60 ++++
>  tests/qemu-iotests/tests/parallels-checks     |  76 ++++-
>  tests/qemu-iotests/tests/parallels-checks.out |  65 ++++-
>  6 files changed, 544 insertions(+), 101 deletions(-)
>
> --
> 2.34.1
>
>

