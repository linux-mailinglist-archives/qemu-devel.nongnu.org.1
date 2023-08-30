Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D5578D71B
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 17:38:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbNGN-00082y-3m; Wed, 30 Aug 2023 11:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbNGK-00082c-FJ
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:37:44 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbNGI-0002p4-7N
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:37:44 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31aeee69de0so4858164f8f.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 08:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693409860; x=1694014660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jVly8InF8p7FiXuF5nJPbvrDcZVJctWFalUn8Eyit7o=;
 b=fZ12dXySEdCmgmzDMogafwNuhMgzZnKlURlrdVIKB+E72jxGBEkA+XBRZ8tL3ygYTE
 DqoYhnowmYISPJ3HS9Prya4y2vLBGhfxx7OiWL8VZpANWJY1MGpxdyX894r0tmEUvhip
 sIikK1mMlFK/LJl2IOS4NEcA64JiWaVabsVhbo4Lamz3OS2bPO3pnWA6prcsiMnHUaGU
 p+y+8KEZNqiupN6Kh84O2St7fvuVe0CRN3bcr9jhNUd3sTgNm5ed6iMrQ6igahsg7h6I
 HK/Hz+fVZdiH2lZ3+8BCVSOUcf5wJLtO7u2Yd/cLhX14iUnyAOfq3cRfitEwKjTI4x6X
 RC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693409860; x=1694014660;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jVly8InF8p7FiXuF5nJPbvrDcZVJctWFalUn8Eyit7o=;
 b=BQsRHYCedLzXwNr/Dy66howFBgv2oO5iwwxhky++yHQNcHHCjbREQtaERMPfeEYgnV
 PxRC8ZIYcXkQ9GhkN3Klf+nj60u7VRWZD2zvhX8HOF0wFXeNpXIhK/sOSKi6qybi2qhG
 QyQyfbe2AgILlQr/9EdfSuHa8bSZLu+Z6f4Bd15jVUrUzBtojNlW++s3sSuDzA7k0uIC
 pqZ08hudPv1Zp6Oh5R2bPv/58OpSWAIQp/SxBnKGQV5U4DoElqEjteH/yckjGoLrYxCv
 GhjR57EssDOL9MAXutu646PsfraoagsV9Vc8Pj+be6jhzCUYngzBvyvPpimByccgBqo2
 boOQ==
X-Gm-Message-State: AOJu0YxqZV6M/THf9PwYW0gfAy1lv3cflTjzOvJAAkU/zEdGmoV36X+i
 Nsszm14QkOnKyh8TCsiyK53OwUq/E5yTA+/UQJg=
X-Google-Smtp-Source: AGHT+IH7sssbJkwA9HSmetcJsE9hvSmOHRiVEGdjjfGSUvRVZQKsBEwXIQNCXR60a1oa9iU1JiVRuw==
X-Received: by 2002:a5d:6787:0:b0:318:70:a4ac with SMTP id
 v7-20020a5d6787000000b003180070a4acmr2333603wru.17.1693409859833; 
 Wed, 30 Aug 2023 08:37:39 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f22-20020a5d58f6000000b0031981c500aasm16932154wrd.25.2023.08.30.08.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 08:37:39 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AE20C1FFBB;
 Wed, 30 Aug 2023 16:37:38 +0100 (BST)
References: <20230828185550.573653-1-richard.henderson@linaro.org>
 <20230828185550.573653-5-richard.henderson@linaro.org>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 04/10] plugin: Simplify struct qemu_plugin_hwaddr
Date: Wed, 30 Aug 2023 16:37:34 +0100
In-reply-to: <20230828185550.573653-5-richard.henderson@linaro.org>
Message-ID: <875y4wr16l.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

> Rather than saving MemoryRegionSection and offset,
> save phys_addr and MemoryRegion.  This matches up
> much closer with the plugin api.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

