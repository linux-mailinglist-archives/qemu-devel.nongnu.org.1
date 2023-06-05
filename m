Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8125A722402
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 12:57:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q67tZ-00028H-V4; Mon, 05 Jun 2023 06:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q67sx-00024N-38
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 06:56:28 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q67sv-0000ks-KZ
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 06:56:26 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f6d3f83d0cso47435145e9.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 03:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685962584; x=1688554584;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ouerYSLbP0WNwgheq4cxSDk0zvNFbxNt6h4WkO7UULg=;
 b=VsIbzIWtttmAna6SREAK8Zsu+qp1e5v6CRqCXaBlTux4nlMN99Y7GbpyST+/yl4eR1
 jwpg9zigKAWTrkFRZXCow+zyCgWrPqJnAeNP4T6v57SftR7IZVcEStwia9IeT4CNgY47
 0udFnBaeiNrStazenSwAFR24eKVCb4tAfSOK2+WJviBOdCZFZo3WsKJLJypP+BpKSKxs
 3EYnp4LYnIaEneQeTIQG/8idYEBTTYCu/qqQHkem+gqSBt1Yrdr2shYWu+d9qalyRJ2R
 R1kj7M+eWXAYla5n/GCSOZbf9ooyxIgcTYKlJyk3xCj8Ygfr2HZxtKJW/S9Qeazfd9Sr
 gIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685962584; x=1688554584;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ouerYSLbP0WNwgheq4cxSDk0zvNFbxNt6h4WkO7UULg=;
 b=Rl5FmQ6C2j3Nwv15UXr7cjA6cSOmB6hPW/UQgSEfuV5Gr+wA+j8bHIekVK15OKQo9e
 MtTXUwoEaV/xxObmsDNcZDdjV2wRlpApQq9dNZsYoamzEjOKWV9f4u0g5JInwQLLrPVd
 pp+eZ0cUJw/4Dm5i8Icz9LjIcoH3B0/nfLcxo0ci0h0ACc5peC7hG+W3rdPBoY4yhpHj
 ytDKJdB3lbbUsGisWHK7N2DgWmvSseWu2MKKBdSpeNN1koD2e8VW858N/dj+3mpgTn8k
 vzWMbaeXGpXU7lkt8bMb/1s3HyoBTwiKb50tr/ipUdEM/Lz6tDYN0/cuMzJxF6nw5bK2
 zPVA==
X-Gm-Message-State: AC+VfDz5MmCkUBCAiXNGj0Xg4UI/ZuRtqbqqso0bDMVUYenZ96rriOch
 UCP4B4QuVQqdMDgFfmn5TZLgtKDTu+wMbow5gNQ=
X-Google-Smtp-Source: ACHHUZ5fPODKzyR67BkTc4z5lU2jwSTjYV8Z3pazr343IeNnf1t9Rcwk0zg9DVt7WQhBEdUzLmQGrQ==
X-Received: by 2002:a1c:f218:0:b0:3f6:962d:405c with SMTP id
 s24-20020a1cf218000000b003f6962d405cmr8794017wmc.41.1685962584125; 
 Mon, 05 Jun 2023 03:56:24 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a7bc8c4000000b003f7e66a51dfsm1291026wml.28.2023.06.05.03.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 03:56:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7EF251FFBB;
 Mon,  5 Jun 2023 11:56:23 +0100 (BST)
References: <20230605095223.107653-1-pbonzini@redhat.com>
 <20230605095223.107653-5-pbonzini@redhat.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: thuth@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 04/10] build: log submodule update from git-submodule.sh
Date: Mon, 05 Jun 2023 11:56:19 +0100
In-reply-to: <20230605095223.107653-5-pbonzini@redhat.com>
Message-ID: <87v8g2yy7c.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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


Paolo Bonzini <pbonzini@redhat.com> writes:

> Print exactly which submodules have been updated, by reusing the logic of
> "git-submodule.sh validate" after executing "git submodule update --init'.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

