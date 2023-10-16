Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B55597CACB9
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 17:00:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsP4U-0007SU-RX; Mon, 16 Oct 2023 10:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qsP4R-0007J2-Pl
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 10:59:51 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qsP4P-0005Vk-EU
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 10:59:51 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-307d20548adso4135379f8f.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 07:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697468388; x=1698073188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jGJEeIBNZqXkW0JTk9WOaffzn7/N73yrhYb7myE5emw=;
 b=dAo6knFqiPfB2eXHKF2wY9si1z2Fcivuq/pAqFGtmUMiRWv/U1/hWdZV7Clqb6oaoM
 2NYZjcdtX4EOelHZs0XuA4sZ4MPacr4NfUvD4VcBiaOVDafXLLOGZQ6ZrG5Pf7NwhLu3
 fIAN0ZcB4Xm/Id6jrdZ68OvE3jzpqtC2azPsziMAXKkjwuBWbEyonX7g20vBUAvzW78U
 nVMEuVdG25+ecQwLnIlvuwDMN5FnCRsKYRO/paEnyhL9NL0MtiNGEWtJEp53yziQZUDN
 FBk3n8sg4rETczuWbr/I6hEMSn06Uviec7euZOkK/RZ+OdhiP2QRgeUpeNqOkKqjhFv6
 sezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697468388; x=1698073188;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jGJEeIBNZqXkW0JTk9WOaffzn7/N73yrhYb7myE5emw=;
 b=MgisYmI9nOWFwK/jGj23sdKPbqxMgmOnfEZ+y9820wDMbg4UxPtitxPiviAC0z+zwY
 /C9czU792wDJvzOFKi4odS+VSfVUcUxGc+HwAszTarglI3TFd3UNXmbeeURILNzGc8dR
 MAJsdwZHgEfA7RcIfSL4jK+LhV6mKpqMct8TXvR+ZBj510aICLVYMp7UF9bfdBJtroaB
 14YsdZ0ptM+V0uVKsDMH0YDH5sQTHwlsxM3hoaatj91EJMEpFzi0kOqugyj12vVvwZLd
 YjCYumonhYPF/qpn9jChWDuvQSptbndBj20Hpi+jEA8vF+OoW4Tx0G0QuJb3vinB33yq
 TFkQ==
X-Gm-Message-State: AOJu0YztN4rBEiKNvgk+EphpBt02URlZN2K1KS0ubS2GlVkEocTPPTA0
 SHy0kKVq+vvJSDP6cE59X8Armw==
X-Google-Smtp-Source: AGHT+IHLmYmGVsLrx5/mabOhBYfXo4r00RDZycR3daDL5dquG71VnhfLJrRVAF1eX5aESCczxcvIqw==
X-Received: by 2002:a5d:5d08:0:b0:32d:8982:ff1d with SMTP id
 ch8-20020a5d5d08000000b0032d8982ff1dmr13589118wrb.7.1697468387895; 
 Mon, 16 Oct 2023 07:59:47 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 h18-20020adffd52000000b0032da46648dasm5988944wrs.8.2023.10.16.07.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 07:59:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 33A2C1FFBB;
 Mon, 16 Oct 2023 15:59:47 +0100 (BST)
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
 <20231003183058.1639121-15-richard.henderson@linaro.org>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: fei2.wu@intel.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v17 14/16] monitor: Change MonitorDec.get_value return
 type to int64_t
Date: Mon, 16 Oct 2023 15:59:43 +0100
In-reply-to: <20231003183058.1639121-15-richard.henderson@linaro.org>
Message-ID: <878r82d34s.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

> This matches the type of the pval parameter to get_monitor_def.
> This means that "monitor/hmp-target.h" itself is now target
> independent, even if monitor/hmp-target.c isn't.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

