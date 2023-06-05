Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E59327223FF
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 12:56:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q67se-0001tF-A7; Mon, 05 Jun 2023 06:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q67sR-0001sw-EQ
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 06:55:56 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q67sP-0000hq-Gm
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 06:55:54 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f60e536250so41194915e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 03:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685962551; x=1688554551;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YWueVv81uYFr8+uWQ0lNKpIBAryfIifziEONhniYJDc=;
 b=mSfihkVZ+04g2MRM5GzWfASGq97r9G/JrlzksGtfQwGdY5rqwFcLE+nwukfDvntVkN
 va6y9bycuc6jIWabk851operFjMgEhHNZBTcT4ZL10VgNzsbJxBg2b8zB5CfSDJheWHZ
 GSuJQu/uC+fjk9xQkDsSsJWO4Z9fhO+MoaA5j6jkEMnZYeX3yborNl3B5qM7WLOcRQh7
 F8H/Aw86BPJYJFhN+4U9M2jjcQHeosUtSmfsodhDcSOoFL4J+84qk5irYuWn1/lHL2s9
 YH6eDWTydsnmnvHzt+yy7yranPd2r9OBCGGETVfPLV+jSrfDm7B5o17UzG3NUQafq2px
 BZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685962551; x=1688554551;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YWueVv81uYFr8+uWQ0lNKpIBAryfIifziEONhniYJDc=;
 b=TWPbrvMgsle1BmZgx1Nq8T4OV9Y/dOhiCae+hughlSjJjCsBX9fVEaA56QYq9WIv5t
 aV0ybaRhi6Qwo6GeXqOsd2FJH5prUnWLZQCyNfhzLwzwQuTfHphu4j1wDSo1NK8znVDr
 YBORFy4x0bybxNzGO/oTzlSZxNCgJa0BBac9RcWUhkaUheUxk3sBufqPDg0NTVZrQMcZ
 JyoNhvFWdIK25KrOYW2/zKhRgzhYFMIkgLt6LNeuTwkuzrlj1Vn9g7jaH04s83tseVFz
 /FzAAOEyAD3Wv86Xr2TZeXdWkTAx/J067evem172hacU4oXozabijwqYRfDlvtdPju1J
 DHhA==
X-Gm-Message-State: AC+VfDz2Ov3SdBuC++3jOnhe2Vn4dHMFJQpGCTFpoHRP7udiJrgXLnxO
 r3jbFww8dZCv7xxevG8Yi0/xyNMFW0vdsd/++Z8=
X-Google-Smtp-Source: ACHHUZ7BLkCqPDNjSWNa0gguFdDPWXUlsRLoxNKqFNKrOghpKYFVnof9kUmqDTqrvtatbMyMcvJLFQ==
X-Received: by 2002:a1c:7518:0:b0:3f6:1ac:5feb with SMTP id
 o24-20020a1c7518000000b003f601ac5febmr7582245wmc.16.1685962551315; 
 Mon, 05 Jun 2023 03:55:51 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 k7-20020a05600c0b4700b003f4f89bc48dsm13945044wmr.15.2023.06.05.03.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 03:55:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 92ECF1FFBB;
 Mon,  5 Jun 2023 11:55:50 +0100 (BST)
References: <20230605095223.107653-1-pbonzini@redhat.com>
 <20230605095223.107653-4-pbonzini@redhat.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: thuth@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 03/10] git-submodule: allow partial update of
 .git-submodule-status
Date: Mon, 05 Jun 2023 11:55:45 +0100
In-reply-to: <20230605095223.107653-4-pbonzini@redhat.com>
Message-ID: <87zg5eyy89.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

> Allow a specific subdirectory to run git-submodule.sh with only a
> subset of submodules, without removing the others from the
> .git-submodule-status file.
>
> This also allows scripts/git-submodule.sh to be more lenient:
> validating an empty set of submodules is not a mistake.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

