Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDD574728F
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 15:19:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGfwB-00028S-0a; Tue, 04 Jul 2023 09:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGfw9-000284-1I
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:19:21 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGfw6-00075i-HS
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:19:20 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3090d3e9c92so7773751f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 06:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688476756; x=1691068756;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eS52ddtp46kuIFZo6uf1JJAgey4a62QPHiUDvV11jPU=;
 b=jGN5SQ/c8+kFZiJxhz5aYlDjJXDsLeECljIA8GAVKoP/8SFI/Wu587S4JkIkzIIkgW
 v4WcIdNeUV71kkIYq6/OLswdf5gkYCXyCR3rnZIjU++1T+7bVQX0uZXnXq8CunMNHDgG
 bgLd0eplhMZqWV9M/6s6R5uuvzrM1P+QDn+TTrNJg/fYBrM+gu9l2Oh2lhvoABJsMqCc
 l0c6FNQEP4G5lVfWadUb/rcWhPWnwU3dRTcBVez3htcZvv1JFpCNYi3m9A0fjFJdHTxl
 FHwFvVz5X7chdSVGe4mFwQYzmJoNZa3+mn36b8dTtYi7blllQDDG+1m5qSiQHyLOLH7B
 jNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688476756; x=1691068756;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eS52ddtp46kuIFZo6uf1JJAgey4a62QPHiUDvV11jPU=;
 b=TEZ3n1VS9S7Xnbb67g+smAkCPL3D3oXhDUEN2osPc5qtyTYKpm2DSfKJkpu3NqpSKQ
 /1KIvgeNS1Gemv9Cxocspgz8IHyJYeLGu0/OlNMOx8jcKYm8xdG7n9p53LTiF/HsHsBU
 5cTAXnuK98LcqdQTZc/lvy6V7Ol8lII7lMk/3883CsqtLliDTR3zIoih04G6sz9ILjU6
 jQsOj+mrCrwgf/TvMxolF3y+5nl/BWdut5dIqwDuFqieU6sBNtIqBBOVoUrRDe5CthPu
 5ph/Kbi+1/hsqX3+2MdgAVxSu8mEAYuGWmi9JAtEMjAKIZ7WU6Pv4Uc+crTPEJsBLwGC
 ErxA==
X-Gm-Message-State: ABy/qLYzzgh6Gw5Cq76Pk2zHZit0wUOtHDN3z1mO9e28EQXonQ9OxVcC
 qnkO33kNhC47sUPjeclbQpPp/pj6BzUIaooqUM4=
X-Google-Smtp-Source: APBJJlEm1hH8wMFRjMyHiWxnCpLWQ6PjCyBM7lgOUJUmQ0l2v6QuYpLBUOZj8Z6sLmmtRYE6bB9otQ==
X-Received: by 2002:a05:6000:1814:b0:314:33a2:78fe with SMTP id
 m20-20020a056000181400b0031433a278femr10636639wrh.29.1688476756563; 
 Tue, 04 Jul 2023 06:19:16 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 h2-20020a1ccc02000000b003fa74bff02asm29865184wmb.26.2023.07.04.06.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 06:19:16 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 949C51FFBB;
 Tue,  4 Jul 2023 14:19:15 +0100 (BST)
References: <20230628072236.1925-1-luzhipeng@cestc.cn>
User-agent: mu4e 1.11.8; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: luzhipeng <luzhipeng@cestc.cn>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] contrib/gitdm: add domain-map for Cestc
Date: Tue, 04 Jul 2023 14:19:09 +0100
In-reply-to: <20230628072236.1925-1-luzhipeng@cestc.cn>
Message-ID: <875y6zhl0s.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


luzhipeng <luzhipeng@cestc.cn> writes:

> Signed-off-by: luzhipeng <luzhipeng@cestc.cn>
> ---
>  contrib/gitdm/domain-map | 1 +
>  1 file changed, 1 insertion(+)

Queued to gitdm/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

