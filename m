Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E14AE774E22
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 00:18:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTV0m-0006Ug-GA; Tue, 08 Aug 2023 18:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTV0j-0006UW-VC
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 18:17:06 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTV0i-0001CN-FO
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 18:17:05 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-317715ec496so5310073f8f.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 15:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691533022; x=1692137822;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FhOKxY+IvGTiT60WqayHqIwnhbP+G712hLczy0GL+pM=;
 b=MIwDOwm6b+dpsbLG1xwPbF+g9JMR+C6MdNOBQBbtYQjXdxWFj+Wn7IUVEFgbR3kB3/
 uj9Wyn9vI5Z408f8nNXTwA0AA0LTqmZCGkGSP7uVf0Uh/B2SJr+Ouyq1tYfabWjWDnkL
 Gk5ZgELQqm4WHAwP+PZ6Dl5ZIUM9NxGQziPRPUGdveAQR2+B9uXQ8IC4OWLfDk1LME6j
 sBtFxJUo5Aljrt3YiS9LRdRD0gEOrN8SodOORRYeBitWUV1A0Izl9/Acd8zyfLvEnZZu
 uJTnnn6YcGLQW9WXldyAspAwE/3LGkKjCK5uSIPLsHtLBASxQwsJaWuxEZKR8MnOTy7x
 SSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691533022; x=1692137822;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FhOKxY+IvGTiT60WqayHqIwnhbP+G712hLczy0GL+pM=;
 b=DZ5LsNzP7bHMW2gNsjo9aXOVKFoslzYdce0JU6TjhQpD7+QeKMF9FvqXcyNBdmx/bq
 b2qTtNwWBPZ+LibX3XZWiU2t5zaOn/E4cxEFG/fcCl1Y8rA8FSIJgbmiFsudblPEUoYI
 pfqKX+ypG66uE+/P7/6A+zBreRYfqPGSeqG/4qcaH/qLufpxfGwC0gWdeGgneEzvSTF7
 MdgWy7YAFMkIUlM3lB/3hPckn6ko9jokQayprjw/gN5n1MUDUxi29VhOoHFLsDXipHA9
 WsjcCszgAAxh8fY8j1wpZ3YtLK3aacbqd5WpyGpnTaHTPhISZEKWvATdYwhk6Yjgh47e
 hU5A==
X-Gm-Message-State: AOJu0YwJvTVPJcX7fgUIjHEbGT5fFpGdVZSyUE7FG+uTfuUXnQFx/hYI
 06jow1Pfi5ptHbjPUYcm6huTHQFAn0AbFtPwi2Y=
X-Google-Smtp-Source: AGHT+IHmeT0/o4yeOdmL5BZOiKlFtJI39frPy2rEeL95KkQToyU1c/Iv/3ec5HUAV6ywJxakhzQItQ==
X-Received: by 2002:adf:ea4d:0:b0:317:f18b:a94f with SMTP id
 j13-20020adfea4d000000b00317f18ba94fmr515939wrn.1.1691533022113; 
 Tue, 08 Aug 2023 15:17:02 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 j6-20020adfff86000000b003175f00e555sm14799450wrr.97.2023.08.08.15.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 15:17:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4335E1FFBB;
 Tue,  8 Aug 2023 23:17:01 +0100 (BST)
References: <20230808164418.69989-1-richard.henderson@linaro.org>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] qemu/osdep: Remove fallback for MAP_FIXED_NOREPLACE
Date: Tue, 08 Aug 2023 23:16:53 +0100
In-reply-to: <20230808164418.69989-1-richard.henderson@linaro.org>
Message-ID: <87r0od5gde.fsf@linaro.org>
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

> In order for our emulation of MAP_FIXED_NOREPLACE to succeed within
> linux-user target_mmap, we require a non-zero value.  This does not
> require host kernel support, merely the bit being defined.
>
> MAP_FIXED_NOREPLACE was added with glibc 2.28.  From repology.org:
>
>                   Fedora 36: 2.35
>           CentOS 8 (RHEL-8): 2.28
>                   Debian 11: 2.31
>          OpenSUSE Leap 15.4: 2.31
>            Ubuntu LTS 20.04: 2.31
>
> Reported-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

