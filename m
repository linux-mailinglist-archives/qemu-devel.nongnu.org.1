Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE347919A2
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 16:28:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdAY5-0006hC-C5; Mon, 04 Sep 2023 10:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qdAY3-0006gv-PC
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:27:27 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qdAY0-0006Ar-Do
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:27:26 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-401da71b83cso14821695e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 07:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693837641; x=1694442441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ly6QzFXbTXv4clgNhUQzjMSrmkZpSTVbbrOSxbJxaTg=;
 b=ITLfluR9uNn8MKqKt8kviCPPhESKw+c2u/wJDwBysakuGVvLsdTtqDV7Wh4JSmdqBT
 PdczcMhowG4y8rq/zYqfOB4UgolRfMSOWoccgJ1tt3g/BrvBJ0uvTqGhAfSldkvre+68
 nb+hPugwwfJqbzLI4OQbgDqLSXpU4zWTYj8LZpZfBNgCsVe0/qNQPO4cuTVhS6DbT/7e
 jg4aXpYaog5azHu4W7m7jM8ue2YsrzKHfPvgfUf26bwHrny7krRa/O7MVR+zFNgUlzKk
 GfGNwCf6pi4ve/tR0B0Kayk177Ucof2JuI/owXp27BRNgdAVgJKpz/uHhuVdamRNKGK7
 Gy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693837641; x=1694442441;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ly6QzFXbTXv4clgNhUQzjMSrmkZpSTVbbrOSxbJxaTg=;
 b=bcED0C2Ts2yHdWyeusGUpebtWRV4yry9npF3R7szr6wgDwwCSlNof1q+kDNZOdZTHn
 YzWD5JZtcWXTQMd6ihx83a0SQKymRd6ohfzaWU0qievxMDS7EGTgm5OX3GsbSzhGiQCY
 qAy4ixlFIGQfd8GAtEdbHBtDg7GEO9NZkaCsWA1CngWLjjpPUOXvUpGXq/G1hBcKo4Eg
 hA0oT2D0526z2n+ANEOibM+/hKs5C6I+uuuA5gCMGBxhMdGUJlo2qBP2v1KmsMDa70Sl
 ziXvvx3HtJkuCCJe7Jco8B+ylIdoYOXisisK8oUJSOOUu+n9ypWmomqRYDXLXIF/tvmx
 IXSA==
X-Gm-Message-State: AOJu0Yy2KoX6UArDUohyPwOQqUXFhDPwjVi8luK4iy7qROu+PsMEF+CR
 I/HrSdDpjAhqYaIM48ISwjNEpw==
X-Google-Smtp-Source: AGHT+IH67E3ZLseyNKAJdx89D+6jO2KkAF/4IGi6Ayj0A9Yau7ESBkGXNtPOigCP8h7ZyJSMQW984Q==
X-Received: by 2002:a05:600c:2282:b0:3fe:2b60:b24e with SMTP id
 2-20020a05600c228200b003fe2b60b24emr7559142wmf.29.1693837641563; 
 Mon, 04 Sep 2023 07:27:21 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 v19-20020a05600c215300b003fef3180e7asm17374977wml.44.2023.09.04.07.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 07:27:21 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B3B2E1FFBB;
 Mon,  4 Sep 2023 15:27:20 +0100 (BST)
References: <20230829220228.928506-1-richard.henderson@linaro.org>
 <20230829220228.928506-3-richard.henderson@linaro.org>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, Philippe =?utf-8?Q?Mathieu-D?=
 =?utf-8?Q?aud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v5 02/20] linux-user: Introduce imgsrc_read,
 imgsrc_read_alloc
Date: Mon, 04 Sep 2023 15:27:15 +0100
In-reply-to: <20230829220228.928506-3-richard.henderson@linaro.org>
Message-ID: <87sf7uhv3r.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

> Introduced and initialized, but not yet really used.
> These will tidy the current tests vs BPRM_BUF_SIZE.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

