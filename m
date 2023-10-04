Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AC47B8665
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:24:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5bV-0008BP-AW; Wed, 04 Oct 2023 13:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qo5bB-00089Y-O9
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:23:50 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qo5b9-0005Bc-Rm
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:23:49 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-690f7d73a3aso30515b3a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696440225; x=1697045025; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fogBr2YhmAG+G2k17CY3PQxSLGyc9G53C7s++FrCtKs=;
 b=JqAt0uScU5jWmCnuPoDlVhGfWtm7/gZlO84h4WAwG6lYYK84oEIV8F7+8O4zX65wSJ
 1KPpwrIF3ghOTa3rJZBnRYZ6HdprTsr5JM3UQEx+X6lg0TpTxqcqxLOGcu6a5ngR4KBQ
 NqrRVH8pjKrQ/F44fNWHf+YUR1bDTQ7Gr4UzJW6HBesTYI36/8SpLhZa3CZ1NDBAOdF/
 9DNnM1p11i47/EjdfwZ2oIZ6KwEO4/PpIRHPlyU84OJxEaKSDZKMe44r3nQxw/NqPuun
 6bcpNbJYE0kDFQbtCJoS7+n09XdYaNF6RC8IHBhXuGEFfT2YVmtuXblwbgC+FORE8vEK
 ggTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696440225; x=1697045025;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fogBr2YhmAG+G2k17CY3PQxSLGyc9G53C7s++FrCtKs=;
 b=EmRZ8/tketWUWp2NvCcd2FivuzrqIf/VrNiVyoyNkYNmezOKhQoULh1vake2vRuy65
 gacxtmbLHg7uxJ9yhAH1LJZ1PM/x913m1JJYyDkfKaJ7jiYrdA88mewvuAy5Oy+kPIwb
 eKpuXLH/lNbHavazFBCAdskKlj+a2zX7garITcBqd3OJLOq5knPhbrj3DjDtMRufmdd2
 jIcqvlAzo7xB4/OR36Y5UqN6kU57RoFH0vbD7gZQ7h5OgSaTaA7mXGsmPNMA6vohw8Kb
 11x2UkHx8hdKrO5bTg6rYBkUAa3coNGs3M+b6K9OUcjMPjV6shKiPjLkLNqtOHtMweVA
 IUFA==
X-Gm-Message-State: AOJu0YzhhEC0Dx23N2TAC5sweYbugrNPTqOH/ItxT6NBV9zfCuRcFUbS
 2XOSjSem9EWUDaHBSaSpe9ytLA==
X-Google-Smtp-Source: AGHT+IH8g+KuPOB85eY4i8bFZqpu7TFmwsCPIRjZkVJBDHC4My889wzDEwz/UcgFLE6JWQn5EbCNmw==
X-Received: by 2002:a17:902:e80a:b0:1c6:7ba:3a9a with SMTP id
 u10-20020a170902e80a00b001c607ba3a9amr3698906plg.14.1696440225614; 
 Wed, 04 Oct 2023 10:23:45 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 b12-20020a170902b60c00b001b850c9d7b3sm3961786pls.249.2023.10.04.10.23.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 10:23:44 -0700 (PDT)
Message-ID: <d688281c-d019-c1ff-6927-d1791911c57d@linaro.org>
Date: Wed, 4 Oct 2023 10:23:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Wshadow: Better name for 'optarg'?
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <14cd0201-1507-bfa8-fe9e-f482c35d21ca@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <14cd0201-1507-bfa8-fe9e-f482c35d21ca@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.528,
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

On 10/4/23 03:05, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> I'm getting a bunch of errors for 'optarg' declared in <unistd.h>:

I thought things like this is why we were trying -Wshadow=local.

I think it's unlikely that we'll be able to prevent all such cases.


r~

