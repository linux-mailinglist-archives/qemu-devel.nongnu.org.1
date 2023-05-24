Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDFF70F33C
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:41:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1l00-0004fy-27; Wed, 24 May 2023 05:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1kzy-0004fV-5c
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:41:38 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1kzw-0007b6-NU
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:41:37 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3095b1b6e02so382980f8f.2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 02:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684921295; x=1687513295;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tp85uCXoT+hOXqFaaXWL2aicOvjMm+5WK+MY7fFBP8c=;
 b=hqf+V9PyXJzw5YzBdrE6dH0eX+tH0aNhR86F/Q1eVvh09ljLvGwsK6L7VVsxtyO2ZJ
 w8BTcqB+A4+0WWSWyHJoUCAAwCTY+ltywmgz23DF64HtLY+90hQiLZmuoEBStTPQXU4I
 /iQg6ZOZIUn9WOXccz0bZ7lWLPJ6WWqgCjt+i6WMut4uSMQNZ6RGvUsI7KV90SvY2qV1
 JEvagO/iWX+HriBfb1hNZNtUqcy13bE+i6nGJIRrubuH3SLDKGbXighxsXVFgZKA7v/A
 Fv4fJec+hnHg1iEmfdSuyuyVC7gWYL9fdsFJ8xgQuJmaYsnmH3gbhWPYYvJHMBPaNj2r
 V61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684921295; x=1687513295;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tp85uCXoT+hOXqFaaXWL2aicOvjMm+5WK+MY7fFBP8c=;
 b=Q+KyIhwCjjFlg7GyRdbbG75AKzDBJiJwnFQbF6jcz7lgkbKdZoB0uJU+OajLk6pSKM
 Oycb4uHpueDa+sZJiZ+5roN+xSV3D5ITcSzygsrrseN2qTXIkzcFhrrB8TZzkjSTNOl7
 cLznkJV6Rkyv5r5jS++mft/Tf4q6TIoEP2ybD1tlvEo533hOp92j7dMohoXxrX8y6Gav
 Y3/pje2fyfmWtGilypqa3mnIDyurxBJSeVygRmUyZMSRPX8otdJk1+9qWdFT9/+PzbX3
 76ZEpswLIXWKPbL86hIe0lPJujYRwqPEW4z7swwspz45ccbgxfyDiHcb3Kmu0HMeN/V/
 zhNA==
X-Gm-Message-State: AC+VfDymAFDL6sxk7bKIUp3EGNJI0SlaKDN6GqKKId8fL2wpDY9mE2D+
 mY9Fn55hk0OtjX41F7pvr4D19A==
X-Google-Smtp-Source: ACHHUZ7HynvRU6q1s2ANtnt4CgK7zX/vvMp83eXKLkR1Ayk6dzhVfd/6HrZimLN4T12K/5yAzh0dZQ==
X-Received: by 2002:a05:6000:45:b0:306:2b40:1258 with SMTP id
 k5-20020a056000004500b003062b401258mr12168271wrx.21.1684921295436; 
 Wed, 24 May 2023 02:41:35 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 d6-20020a5d6446000000b00307a83ea722sm13870290wrw.58.2023.05.24.02.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 02:41:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9CF831FFBB;
 Wed, 24 May 2023 10:41:34 +0100 (BST)
References: <20230510202654.225689-1-iii@linux.ibm.com>
 <20230510202654.225689-4-iii@linux.ibm.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Laurent Vivier
 <laurent@vivier.eu>, Dominik 'Disconnect3d' Czarnota
 <dominik.b.czarnota@gmail.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Andreas Arnez <arnez@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH RESEND 3/6] gdbstub: Report the actual qemu-user pid
Date: Wed, 24 May 2023 10:41:29 +0100
In-reply-to: <20230510202654.225689-4-iii@linux.ibm.com>
Message-ID: <87wn0yvzg1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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


Ilya Leoshkevich <iii@linux.ibm.com> writes:

> Currently qemu-user reports pid 1 to GDB. Resolve the TODO and report
> the actual PID. Using getpid() relies on the assumption that there is
> only one GDBProcess. Add an assertion to make sure that future changes
> don't break it.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

