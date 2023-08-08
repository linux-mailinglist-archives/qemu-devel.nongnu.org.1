Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4607739D3
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 13:00:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTKQj-0000AR-Gn; Tue, 08 Aug 2023 06:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTKQh-0000AC-FE
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 06:59:11 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTKQf-00038p-7T
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 06:59:11 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fe490c05c9so22238355e9.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 03:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691492347; x=1692097147;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rlQ0BTV2Yy490+eOxvJs93/Wtej0/Ze5ftCbA98dNaI=;
 b=EyHj4xBfEFyzOIZhlKWaSP14ILd23DbOC7klRXIcoVTkBa8WvieDtBnZqVtq0RkqMB
 sp9FqGOcFySiriKYIOT7hsx+AIpD7CsmLX41P7A0bX2fbbJ9PpQZnUCU9A7zEdAI730X
 PQCWf8Yrt5Uxu/33OVINLMQn//pi/2ELZ2TmfWtxbRTxRJTH4DEsC8wIw7W2yLnK+hXG
 hR1xQv3PpNScLKnd5AQb2GWRoYVL30OKkIa5pksMn+aexJZW7+mRTGkBIMrd9l3iV62O
 uLYS1GS+Be83F3zfefAbuVvlE34rHVECPVXXp3AtSZfJdatAJo7uHAHLg7DRu+bwGgRi
 Kljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691492347; x=1692097147;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rlQ0BTV2Yy490+eOxvJs93/Wtej0/Ze5ftCbA98dNaI=;
 b=dNRRhTxS5fUiBRn2Inm+g9D/q25SXcZAMwD7uWoU1JPP9oBjo6pL8vCbSucvcXTJQL
 3T/Z/l8usK304sI8d2M6ETek208L04HtADJOQtrzcEi682+vZkLxBej+NPQyC+T7MkUJ
 hkMpvnzaMiNWm2FvX8QfBavmkBHv7x5y5u6hNL8ryTGhtL+xK9it+wBCi9nh3TDQ1k7+
 j1UWaO0P5eo7y+crfbMgwiE5APbpssYiVh/f5YXHEtl4t6Af2xsFNC0u9y8V5gQnVhRE
 kz//HJd0qricBMv8V2MA4liRLzA/DKVMWc/o6V2MO+qiUwP/gI6gyV5sJNcpUwhG10n8
 vwXg==
X-Gm-Message-State: AOJu0YyfCnFApCtdJ5TzpM7YSEUQcAsDWqGIWNLSoNmu5DJHbfkJ9QCf
 2shNaG3VmEHzJoO+e17tqUC4Yw==
X-Google-Smtp-Source: AGHT+IF0yFAq/UTa/EZKItL1zIzYRcAPeLqQYYDEfbZkamIXvIWeTqK0/D8EpK7cqm3MX3wlHtKaFA==
X-Received: by 2002:a05:600c:a2a3:b0:3fa:91d0:8ddb with SMTP id
 hu35-20020a05600ca2a300b003fa91d08ddbmr7445882wmb.14.1691492347401; 
 Tue, 08 Aug 2023 03:59:07 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 r5-20020a056000014500b00317dd7b96e7sm9384718wrx.23.2023.08.08.03.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 03:59:06 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 48F481FFBB;
 Tue,  8 Aug 2023 11:59:06 +0100 (BST)
References: <20230807163705.9848-1-richard.henderson@linaro.org>
 <20230807163705.9848-8-richard.henderson@linaro.org>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu,
 deller@gmx.de, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH for-8.1 v10 07/14] linux-user: Do not adjust image
 mapping for host page size
Date: Tue, 08 Aug 2023 11:59:02 +0100
In-reply-to: <20230807163705.9848-8-richard.henderson@linaro.org>
Message-ID: <87bkfh94w5.fsf@linaro.org>
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

> Remove TARGET_ELF_EXEC_PAGESIZE, and 3 other TARGET_ELF_PAGE* macros
> based off of that.  Rely on target_mmap to handle guest vs host page
> size mismatch.
>
> Tested-by: Helge Deller <deller@gmx.de>
> Reviewed-by: Helge Deller <deller@gmx.de>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

