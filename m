Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4ED799FFB
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 22:55:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfRRm-0006m6-Kc; Sun, 10 Sep 2023 16:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1qfRRk-0006fW-NG
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 16:54:20 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1qfRRh-0006Fo-F3
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 16:54:20 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2bceca8a41aso60111181fa.0
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 13:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=roolebo.dev; s=mail; t=1694379255; x=1694984055; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1bn3yplVCt2/1GUjK4d8n+lRv4mY3WpbHKRy6W9GJNo=;
 b=RDl5VYy8oWM/0mA3/potv69vjn2mt/TlVwZT9u+Hd94NwS/9iFRNlaW98FA2zlUGP/
 WCiWAqGF/nVQRALyNkyiradI7b9XcqQ5r0WyAdKWLT5n1RLoJt20cStG1oC6guJoAhkE
 wlWjGSBJ/uiBs+VlPcCALvy8DjTPi23POQhEkSnBcMBEz3qrUyAnvpE7/KGysaAH8NQD
 Uib7DQsLdBBwUDzUGoTONN23kBN8Jfc0OVjiqmyNtaqLw9HJqPnP7Mwm6FgaVCLaXeuh
 Ik/4dSyAJRLPAGIP0HBXo8EBqXdvqXdJVa8y4vWOZu+lfde53zP8JftCy73lezZN1jpP
 IIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694379255; x=1694984055;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1bn3yplVCt2/1GUjK4d8n+lRv4mY3WpbHKRy6W9GJNo=;
 b=eVdWHiQvqQrjeI/NDnPqYWT8r2HmO3L7kXXNN8AGcGXq24eNG7suMzs34mG5AZHEJo
 cpLN6BaiSppyhgKPzQ5axKftrd2r6d6Tz0KNoexhkjYdqkUkJV8N6dlTnaSTjhr/Ahup
 7lyWsR1ptntVy9sE6L9ZUxE5r5u/XVTPIrG+uHhM5r7w94CnppeTBgbUwtM/9UF/S6em
 +DsXGRGGrRNEJNpddGTP1pUQCmmhb/H9MqjCbvEenkuFffI8s6kHx6qjKnhf7g/7Z6/Q
 /5091kQhVaITRAbAR88ZRxEU7k0VeCAk2xvK8jVO8rujwIh1dG9NCi6+u0wNrXkVC2wr
 8vDA==
X-Gm-Message-State: AOJu0YyFWNXI/dppczmkXL9iPscgKw0rkIzHegTjf+OEVtGeWswbECan
 AIh5chaXtcrNJ9vXLV3CUOtT3g==
X-Google-Smtp-Source: AGHT+IFFb7qvzKNLP3eMXeGM388gDwYuIQp12qUyMnLEnNydMVIay+4E92EVKm+ld6is2kbK7uWOxA==
X-Received: by 2002:a2e:99c9:0:b0:2bb:afad:ffdb with SMTP id
 l9-20020a2e99c9000000b002bbafadffdbmr6625201ljj.28.1694379254627; 
 Sun, 10 Sep 2023 13:54:14 -0700 (PDT)
Received: from localhost ([149.255.29.239]) by smtp.gmail.com with ESMTPSA id
 j23-20020a2e6e17000000b002bcc866ec9esm1226116ljc.119.2023.09.10.13.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 13:54:14 -0700 (PDT)
Date: Sun, 10 Sep 2023 23:54:09 +0300
From: Roman Bolshakov <roman@roolebo.dev>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cameron Esfahani <dirty@apple.com>
Subject: Re: [PATCH 1/2] target/i386/hvf: Remove unused includes in
 'hvf-i386.h'
Message-ID: <ZP4rya-AtU3-1m9E@MacBook-Air-Roman.local>
References: <20230905123906.6880-1-philmd@linaro.org>
 <20230905123906.6880-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230905123906.6880-2-philmd@linaro.org>
Received-SPF: none client-ip=2a00:1450:4864:20::22f;
 envelope-from=roman@roolebo.dev; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 05, 2023 at 02:39:05PM +0200, Philippe Mathieu-Daudé wrote:
> The only non standard type -- CPUArchState -- is forward
> declared in "qemu/typedefs.h", so no particular header is
> required here.
> 

Hi Philippe,

Reviewed-by: Roman Bolshakov <roman@roolebo.dev>
Tested-by: Roman Bolshakov <roman@roolebo.dev>

Regards,
Roman

