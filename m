Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F9B77C350
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 00:16:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVfq2-00023M-7Y; Mon, 14 Aug 2023 18:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1qVfpj-00022M-8J
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 18:14:43 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1qVfph-0004wk-NP
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 18:14:43 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-686f25d045cso3305455b3a.0
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 15:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692051280; x=1692656080;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Gis2biPu65VTqKerUhaZe5+i57GcGp/Ma1+Uc/E8uHA=;
 b=sCCG/WebnMKTpJZpi7NPTyvwwZctuRtp4nlSWgRkn5VKwRRnolS1ZU0ZwNpY0BmeoY
 LHcanxha7VedZYTKjTuG+UQxrhrYoJQ3QlE6+PxUbp0SPlk5HV9KSbaP0iRraBeRSF+7
 lMIhezmgXDjonXXK7dmriv1gbdLsUYDO+Gh+5jsRjHL4FP2rTLGMfoD0HS5MBbAQs8Vj
 LCTYxXsKUGnAbH4ynYYslOWWqahSAayKqibR4Vkg6vypWXqPeyf6maDXe+an6uoxtLc6
 9dafkkhAxwTAssZOpyjzJC5aQcAgvoZVFFVlZG/TvKBU5H2v1qubzZmCRoX/5MN8Wg8w
 j4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692051280; x=1692656080;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gis2biPu65VTqKerUhaZe5+i57GcGp/Ma1+Uc/E8uHA=;
 b=j6P+L0ZXN3dJjw5Aludlp1XletJr4ql0+c1M0RtIf77XQRMb0bU+wCFfBlcrGE8kep
 uJVXeBVMk8tabx9ws3xkFXaoabrswjaO/XXUvXhJohg/z2u2oRomEEnhiUDaRCWo79xX
 NArGRuaYEOYjkja3VX9L24erWbWKWiNXyxIFHGXyrPmnkS45jo+bAFnBdTAs4+o56jnU
 v0SzIrRQKw9aieMFs94YglkF5uAjwUcJszB1Rf4d+K2lwvUMGboSxpYiXoJstIfPL73r
 UDUkOKe/vqbhAnMsWPub4oAS52tVR4Fxfy6nI4V6KBpbcthiKK3Diay1Rk0oD6n2yhmA
 lo2A==
X-Gm-Message-State: AOJu0YzOcdNzrwqFdph4sidihPHc0Pg3WfsVHGOAjvIBhLwBUnL6IDdO
 AZCplsmYqlvzwl9GrQ6sqLo=
X-Google-Smtp-Source: AGHT+IHNNpZSKLUvGz+r83qdIrgbzbxphSeKT5WeTUZsMw1LngqpP5X7OBvUitFwiQ4RzpVQH4SM6Q==
X-Received: by 2002:a05:6a20:160d:b0:134:ad98:fb0c with SMTP id
 l13-20020a056a20160d00b00134ad98fb0cmr12762436pzj.4.1692051280030; 
 Mon, 14 Aug 2023 15:14:40 -0700 (PDT)
Received: from localhost ([192.55.55.51]) by smtp.gmail.com with ESMTPSA id
 5-20020aa79145000000b00679b7d2bd57sm8383298pfi.192.2023.08.14.15.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 15:14:38 -0700 (PDT)
Date: Mon, 14 Aug 2023 15:14:37 -0700
From: Isaku Yamahata <isaku.yamahata@gmail.com>
To: Wei Wang <wei.w.wang@intel.com>
Cc: peterx@redhat.com, quintela@redhat.com, isaku.yamahata@gmail.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] migration: refactor migration_completion
Message-ID: <20230814221437.GA3377960@ls.amr.corp.intel.com>
References: <20230804093053.5037-1-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230804093053.5037-1-wei.w.wang@intel.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=isaku.yamahata@gmail.com; helo=mail-pf1-x42c.google.com
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

On Fri, Aug 04, 2023 at 05:30:53PM +0800,
Wei Wang <wei.w.wang@intel.com> wrote:

> Current migration_completion function is a bit long. Refactor the long
> implementation into different subfunctions:
> - migration_completion_precopy: completion code related to precopy
> - migration_completion_postcopy: completion code related to postcopy
> - close_return_path_on_source: rp thread related cleanup on migration
> completion. It is named to match with open_return_path_on_source.
> 
> This improves readability and is easier for future updates (e.g. add new
> subfunctions when completion code related to new features are needed). No
> functional changes intended.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
> Changelog:
> - Merge await_return_path_close_on_source into
>   close_return_path_on_source as the later basically just calls the
>   previous;
> - make migration_completion_postcopy "void" as it doesn't return a
>   value.

Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
-- 
Isaku Yamahata <isaku.yamahata@gmail.com>

