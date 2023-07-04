Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE72A7471B7
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 14:49:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGfRp-00028B-6p; Tue, 04 Jul 2023 08:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qGfRn-00027m-3h
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:47:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qGfRl-0006wy-IR
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688474876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0qdKdd2JjSIWDQbbpH3sWspFB6B7JyV/Xsxdc+/CVHw=;
 b=eBf8Iz25VOoihqaNx2k6bOEDm8/5QRZnOnmkCACWOvPEvIcM3LO1CFFzMiw9Th+YGxM86O
 LxDNie6Pj2AXjlXyEPCXyMLbbvARBpKoaRKAwAbVNRNAj29F5re0cWHvRkqtzj6INYk15a
 zOKlSuEG3wKykAdzPRjOVNLIik/9Fjk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-rDQfwXBOMVyWeBpPN5xjJA-1; Tue, 04 Jul 2023 08:47:55 -0400
X-MC-Unique: rDQfwXBOMVyWeBpPN5xjJA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7675583f2d0so478072085a.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 05:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688474874; x=1691066874;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0qdKdd2JjSIWDQbbpH3sWspFB6B7JyV/Xsxdc+/CVHw=;
 b=iJqw2nZZz98cLRZFfb4CljJFG8nC6jX/SIRDGZ3S09EFU9ajAI4EHh2FieZYPV0MeA
 G2IMQmzzD7lIk8jd3gPjEaUgoUsIr9rJO/hUxJnQnhVkxwJPh+uror83ijeQGhnBkGJM
 x7gmABRs/wTt2K1jxhSwvzj06nWFUb75h/tjvMw33pB7x2fk0G5m1a3/VKyGOlm+M8dJ
 /14rNUzM8SUM7zxJzCsfKxGcI29xFexueUNMbzE4V/5U1lLp9SSqeLWAsShS0Edw3xre
 yH74Q/mVpRKN2njOIfmA46rAQO4wN5caFQKJEvj0rZbRsBzIvXcmE1SvKGtcP5Cqxt6f
 OqBg==
X-Gm-Message-State: ABy/qLatGj+Tdn/UHk4LvUwjl7ZE6EwGs2AvYUXqQBfFcI2tzWpcDlAB
 9HJL+4LKKk+o8oLFzpDXP648VLmQhxtolAgqBHJ/XhxyFt6OxABwpj3y9Ub0e31R7fbuAFUXIgR
 UQeo+zAb2XkcadWs=
X-Received: by 2002:a05:620a:2888:b0:765:8063:c369 with SMTP id
 j8-20020a05620a288800b007658063c369mr11435601qkp.74.1688474874616; 
 Tue, 04 Jul 2023 05:47:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEB6elIZG+r9aLyXAKw5EMlgFeh64jf/BfbkcpQ+JxmcExh5qMxx9LsW4gMcXeLdxg6Ex9/FQ==
X-Received: by 2002:a05:620a:2888:b0:765:8063:c369 with SMTP id
 j8-20020a05620a288800b007658063c369mr11435591qkp.74.1688474874440; 
 Tue, 04 Jul 2023 05:47:54 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-163.retail.telecomitalia.it.
 [79.46.200.163]) by smtp.gmail.com with ESMTPSA id
 q26-20020ae9e41a000000b0076722cbcb97sm6757293qkc.33.2023.07.04.05.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 05:47:53 -0700 (PDT)
Date: Tue, 4 Jul 2023 14:47:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Qing Wang <qinwang@redhat.com>
Subject: Re: [PATCH v2] block/blkio: fix module_block.py parsing
Message-ID: <wmxryeyqf5ww3hgigdyxf6c4pizqhwt63bpb5rrrvjpthayiyo@i26thnboapuf>
References: <20230704123436.187761-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230704123436.187761-1-stefanha@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jul 04, 2023 at 02:34:36PM +0200, Stefan Hajnoczi wrote:
>When QEMU is built with --enable-modules, the module_block.py script
>parses block/*.c to find block drivers that are built as modules. The
>script generates a table of block drivers called block_driver_modules[].
>This table is used for block driver module loading.
>
>The blkio.c driver uses macros to define its BlockDriver structs. This
>was done to avoid code duplication but the module_block.py script is
>unable to parse the macro. The result is that libblkio-based block
>drivers can be built as modules but will not be found at runtime.
>
>One fix is to make the module_block.py script or build system fancier so
>it can parse C macros (e.g. by parsing the preprocessed source code). I
>chose not to do this because it raises the complexity of the build,
>making future issues harder to debug.
>
>Keep things simple: use the macro to avoid duplicating BlockDriver
>function pointers but define .format_name and .protocol_name manually
>for each BlockDriver. This way the module_block.py is able to parse the
>code.
>
>Also get rid of the block driver name macros (e.g. DRIVER_IO_URING)
>because module_block.py cannot parse them either.
>
>Fixes: fd66dbd424f5 ("blkio: add libblkio block driver")
>Reported-by: Qing Wang <qinwang@redhat.com>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>---
>v2:
>- Drop unnecessary backslashes [Stefano]
>---
> block/blkio.c | 108 ++++++++++++++++++++++++++------------------------
> 1 file changed, 56 insertions(+), 52 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


