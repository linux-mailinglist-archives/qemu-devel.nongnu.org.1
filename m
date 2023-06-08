Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBEE728987
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 22:33:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7MIC-0006AV-Ts; Thu, 08 Jun 2023 16:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7MI9-00069v-RS
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 16:31:34 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7MI8-0005qx-3U
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 16:31:33 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-656923b7c81so848148b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 13:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686256290; x=1688848290;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DMNYQf7HnfSYfg63oYvfBWZRDaJKLZC8ashD6BHNcTs=;
 b=DGoGAngbOtj/99PsedBH9ATQsrJXMO8MnK+W1428b/rNaLcmgtEREhTChRi3AjoZkO
 8NOVXqruREtC4ObS1rkiWCEycK5d4gDKe+mfXeu+n98qeW+jFZtOn91x64cGusv9eH7w
 cSy0F2X4PIo+QPSnjHSQOLR6sZ7DuftABYYt+eEe1A8eYFZUUAYuyPJX1mHucLqJlsjk
 +cIwrAS0asXiSXNVpuA8eV5qDJdcwduZ1UaT5X2X4LEKu+3POAUlKZGBIV8TbXQRnpsi
 bCqzGLrJzkd4vXXTMg/VrhGxpxXZn1djl6/rLxDDlnZ+9f758RID96/2Ufv1dZBmrBD3
 8HrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686256290; x=1688848290;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DMNYQf7HnfSYfg63oYvfBWZRDaJKLZC8ashD6BHNcTs=;
 b=XGuEyTJ/ZzpJOaMr0fbkJxzdfSAoanrczilnPXka01sasoQu2eSpZ20WR5BCd2kqOg
 UBGKezJ9uJAysK05Eurlr8HkKmyb4eYxXHJx9oGiTLowZ0qmU5z/R/sFgOfhuAQ2Lo6l
 38rl/E7T1Khnk5atfg9yqHeFtNP76BNWUE4G3GNtF0MBcX+AwauKjn3HPLW6MYa6A9wk
 OR8br0hrOHOL6jCrS91DqXhRYbWjGi9oEbBE4nQhMzYXgB8Z8XGUa9DcTqYVIX+irABA
 GD+BVxTuGaDKJQL4PW2dUhMQe0NiO1MuTaJymsNIYXybkrvF+5bVJFDth/VZtvhDZOOA
 wX2g==
X-Gm-Message-State: AC+VfDznODFvKDD+y1DeiZGrNZWJ6axQKm+vF/yEDk8qDTb69swab2P/
 eWdgT+03PYC+O0SRPy1KFz8nCQ==
X-Google-Smtp-Source: ACHHUZ7w7PexzgBZAyRtIrIi4XB+vg/isBZwx5LUYLlwiEYq0zJ112hv3m2By8oRzlMtTaR1xGw27Q==
X-Received: by 2002:a05:6a20:734f:b0:10c:4ff5:38b7 with SMTP id
 v15-20020a056a20734f00b0010c4ff538b7mr5082943pzc.6.1686256289829; 
 Thu, 08 Jun 2023 13:31:29 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:b071:df63:5761:f449?
 ([2602:ae:1598:4c01:b071:df63:5761:f449])
 by smtp.gmail.com with ESMTPSA id
 s8-20020aa78288000000b006328ee1e56csm1481913pfm.2.2023.06.08.13.31.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jun 2023 13:31:29 -0700 (PDT)
Message-ID: <55736db1-9430-25e2-d2a0-b8671210e9e9@linaro.org>
Date: Thu, 8 Jun 2023 13:31:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 0/1] 9p security fix 2023-06-08
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Yanwu Shen <ywsPlz@gmail.com>,
 Jietao Xiao <shawtao1125@gmail.com>, Jinku Li <jkli@xidian.edu.cn>,
 Wenbo Shen <shenwenbo@zju.edu.cn>,
 Mauro Matteo Cascella <mcascell@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
References: <cover.1686236977.git.qemu_oss@crudebyte.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cover.1686236977.git.qemu_oss@crudebyte.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/8/23 08:09, Christian Schoenebeck wrote:
> The following changes since commit 45ae97993a75f975f1a01d25564724c7e10a543f:
> 
>    Merge tag 'pull-tricore-20230607' ofhttps://github.com/bkoppelmann/qemu  into staging (2023-06-07 11:45:22 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/cschoenebeck/qemu.git  tags/pull-9p-20230608
> 
> for you to fetch changes up to f6b0de53fb87ddefed348a39284c8e2f28dc4eda:
> 
>    9pfs: prevent opening special files (CVE-2023-2861) (2023-06-08 17:04:58 +0200)
> 
> ----------------------------------------------------------------
> * Fix for CVE-2023-2861.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


