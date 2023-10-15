Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E387C990C
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 14:58:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs0hX-0001bp-06; Sun, 15 Oct 2023 08:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qs0hU-0001Yn-Po
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 08:58:32 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qs0hT-0005Bi-2l
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 08:58:32 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40572aeb673so35702655e9.0
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 05:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697374709; x=1697979509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8SvY6ZrYKBVeoKWp4PBdS4rqqcbZFDZg7e67tWjoM5I=;
 b=xhZ4mKtHurUrQW09XWQQ5i7uuY7bpY5cmRva/T1Tlz9B+LmgTp4tKHinamn/VFpdWN
 ui5t2IY9vMBLnmJ2l64OFYs6UX5j18rg3DHYzXE65+8GB4NZQiUq4O9Pk6BjoU30UcSG
 Zq9kpUzU6B/azGXyr4d1MST1TVkb6LpBaPdqqa9HTHQqrb5ZhEGcFtr2HDdnbAjy6T9F
 RPgGa3hKq1O7z29J/YNGsGgxqh31NKgRYRSno3lbXrmZKdK+HUM99/2YJsuxqSvFGXKv
 Zs8hTOTEzlpFITLIq1h/KXdSmcds8D3UgJWPrL0dqndkY4sbNIQ0g9DRtQmjiELJR6ak
 eKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697374709; x=1697979509;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8SvY6ZrYKBVeoKWp4PBdS4rqqcbZFDZg7e67tWjoM5I=;
 b=FwD6qXfVfRgv+pK5CjSfi7SAZ4L61gtB1yodMRp8ITOFuIuUzHqM04zKJ/LVNq+Hzr
 XxpMylDr7YJdJsKnHBcG93TmvlHVh7MvjbaG/38ueTVaUrWJH7BylRxhSZ2IxRPv46aB
 xCXC31DKj1+z9klR/DuWxWmrXZKSkovBFfcOCT66i5eGZ7o8yr0+pwUni987IGjgQqCj
 fJd3kpsRpe4Wp6F9lJSgUjFEActjJ9FphSDgVzNHKWpqw+g+whScaRU77kbztcp5sT2a
 NYRuNwbSOTXgO5Kbxf2/IluUA1Ci8p6FsShyrtQZb32Pk2H/krsE1bb6rvuxK70D0Hts
 KPoA==
X-Gm-Message-State: AOJu0YzqfSpbBTZOpHLU/Sz+jEC86uI9WX5PXLCG9Bv4dYzHjAogVpEG
 LVQUkp/zbvFdZwRa0lVTXeT91phWx82XBUvkgv8=
X-Google-Smtp-Source: AGHT+IFr94bK2pEyf1IWMZvJzD1kpUUifUZFZmU6d+3nSooBM6pIXGhhbhYcQRmoBGlfqkBYYIBMaA==
X-Received: by 2002:adf:e0c8:0:b0:320:920:42b1 with SMTP id
 m8-20020adfe0c8000000b00320092042b1mr25989491wri.53.1697374709060; 
 Sun, 15 Oct 2023 05:58:29 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 p9-20020a5d4e09000000b0032196c508e3sm4259278wrt.53.2023.10.15.05.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 05:58:28 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 491D31FFBB;
 Sun, 15 Oct 2023 13:58:28 +0100 (BST)
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
 <20231003183058.1639121-4-richard.henderson@linaro.org>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: fei2.wu@intel.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v17 03/16] tcg: Record nb_deleted_ops in TCGContext
Date: Sun, 15 Oct 2023 13:58:23 +0100
In-reply-to: <20231003183058.1639121-4-richard.henderson@linaro.org>
Message-ID: <87fs2cxcsr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


Richard Henderson <richard.henderson@linaro.org> writes:

> Record the number of ops that are removed during optimization.
> To be copied into TBStatistics when desired.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

