Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDFF8224EC
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 23:46:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKnVZ-0001al-Kz; Tue, 02 Jan 2024 17:45:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKnVY-0001a3-0d
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 17:45:12 -0500
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKnVW-0000T0-4n
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 17:45:11 -0500
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-36017ab9760so23270715ab.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 14:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704235508; x=1704840308; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=auuogxhODAyeTAXk1aM8FKif/dnKPBiqqExdH8L+uR4=;
 b=F1MXFUmVmTyEAa2zlihtMAN3LzWRm0NUag6umhZiwobZqJOvUn6Su3rdV8TQEtchpR
 2GKDFZWhXwILIbWkm9D43g0Qne+9jlgsnrv0ICXG5ftEIZyJwdydeYlDvW6K44RA+Xgy
 RCNGbFmDmKO5IVg+zv388LF304LGiIo9PZpfi6/icSWJjksQH2pn1b/7TkouunvDOYay
 0kchD5uHWdEtBKBtKSfQ5KbF7kjVOVd8xJREKmxnPKXLyNXMlnygS/d37nOv8kZ8bgX0
 MxugKoqdpj15u+9GDUc+fnNzBwdwg7N5oli264wCUBhUo4FpKo9KdrfZ76ObHVXqrDYO
 fX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704235508; x=1704840308;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=auuogxhODAyeTAXk1aM8FKif/dnKPBiqqExdH8L+uR4=;
 b=LdIV8XxTRPpury2QXbviRJr/K0qUzTi/fiNoO2MvMwbC9/s5hau5LlQp3urC2s3xdA
 +2C/tp6HGfsuzqee96+6C6I+VTltg9RlwzbxgGuk3Glo4AaujjNw7AFXZd9F2Mxsd55v
 ILgrlYEekr1xV6J5lMsPJ+PsMNMcGQNGvdKtFtJyC2iZFEd8apIwQjksSyAwcKSATRHo
 ZUuryX9adZ4MRukv7cGW7OsSaARigDHqfz0/qunk6QMDwxDinwCh31caZSiTaOldl9Xk
 MQNIED3ip4Z1Jls2II4w0ZzsIJsnFrw2jnRYyFg/jo2ZQ6u4+CTMnte6FjEt4badPToq
 QGAA==
X-Gm-Message-State: AOJu0YwqDCEm/sdS9hBijGIuO/1pjytDqiwu2K5MyS3++a78mx5OdBV/
 ylmFw0AwKFL0WFVeETvCiO8emqx762bW/g==
X-Google-Smtp-Source: AGHT+IF9oWP911JrqvLyTxrhm22gQued8ChmVcxb+6K95e/KJX4V7ur6Cvkh2PzFdxsX1FwR5XaEjw==
X-Received: by 2002:a92:c54b:0:b0:360:bfa:4143 with SMTP id
 a11-20020a92c54b000000b003600bfa4143mr13914540ilj.44.1704235508623; 
 Tue, 02 Jan 2024 14:45:08 -0800 (PST)
Received: from [192.168.50.95] (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 v5-20020a632f05000000b005c259cef481sm21082979pgv.59.2024.01.02.14.45.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 14:45:08 -0800 (PST)
Message-ID: <c4e0c179-0fe3-4b16-9a7d-1298e018dbb7@linaro.org>
Date: Wed, 3 Jan 2024 09:44:59 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] qdev-properties: Add OptionalBool QAPI type
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Habkost <eduardo@habkost.net>, Frederic Konrad <fkonrad@amd.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20240102160455.68612-1-philmd@linaro.org>
 <20240102160455.68612-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240102160455.68612-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::133;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x133.google.com
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

On 1/3/24 03:04, Philippe Mathieu-Daudé wrote:
> To be able to distinct whether a boolean qdev property
> has been set or not, add the DEFINE_PROP_BOOL_NODEFAULT()
> qdev macro based on the tri-state OptionalBool QAPI type.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   qapi/common.json             | 16 ++++++++++++++++
>   include/hw/qdev-properties.h |  5 +++++
>   hw/core/qdev-properties.c    | 10 ++++++++++
>   3 files changed, 31 insertions(+)

How is this different from OnOffAuto?


r~

