Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F59B82DF27
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 19:20:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPRYT-0005wD-Fz; Mon, 15 Jan 2024 13:19:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rPRYP-0005vy-FQ; Mon, 15 Jan 2024 13:19:21 -0500
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rPRYN-0006IA-FU; Mon, 15 Jan 2024 13:19:20 -0500
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-20757468411so1451575fac.3; 
 Mon, 15 Jan 2024 10:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705342757; x=1705947557; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :from:to:cc:subject:date:message-id:reply-to;
 bh=17w/KxWNXhQ5Lj7cONR0KJHLKKkWZDOQAbvH5ro+QSA=;
 b=g3g5H/un7iMdO4mkhpJMtIXdjKwRn9AmrbH6gQ23HgITJBCnO/16pa8F0Uyogxbj3W
 HIdhqNhMvWw/kDH+4Ih20wMvJYRdh76rqek3hFP6xAI7FjfwsgQnuKtBUpDIuamkMKGa
 PxSkufop5K/a6NQW8k6GAD12nufwB2/ozkM3pNCBL2qgJ9s0Vi4XZQjM4qm3Y+r5NR2b
 Y+dgdItth0GgpQigfLTm+WRdLCT4nd9qO7xm9trioPgsEnoOUhZLZi5MmyAf8iSn0uX1
 RxA+Zd+4x9ArJnFdbHPObiQ0YyuP1AGPPebZI4OKaEa4yGguY1l1GsWXqHk8SVFtuB8L
 ZngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705342757; x=1705947557;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=17w/KxWNXhQ5Lj7cONR0KJHLKKkWZDOQAbvH5ro+QSA=;
 b=xMDzLNe3g9yfMUlSyN727x+S/tKtflrkCVQflye+s++o+gUXpEkSqwdYEr9qpvgg1Y
 p4FUm/EeW9EL5WyPuHLBQTfp1rb0bPJOOS4DytikU7fuSfDXhB3CKlGLT/IGXxUB1wLS
 Zc/SiZ2uWGXTeYXOUNp9sOsaO13YQuqX8nRCbUojG4habp9Sje8LeZNwXJPBXMWGkUhf
 2haMrGs2wF/HGGnHJvjzbRAsiQO0ElLqB9alBEgSOo4aztcAR+0jR5p5CuK/GCWEM2gV
 aqtduUoDZrGHHHx3VVpsEQj4PTVipZvdbMSLgOTJ4AN2K0baZcaCyzjvLNxIRcOfcyJk
 Ft8A==
X-Gm-Message-State: AOJu0Yzl+96khTza8wH6sHnZomDooZq0Z3eMyjlPluVB7toSq/a/qnE4
 ytcoyIdvOYJBapzG0fKoCxM=
X-Google-Smtp-Source: AGHT+IESibVRE/5t+Bf7NS9/wItSUyGsbdIBCs9UYuEOzqFGvvndJFqbLr877GNr5myX3Hy0GyAXNw==
X-Received: by 2002:a05:6870:fe97:b0:203:efb2:ee02 with SMTP id
 qm23-20020a056870fe9700b00203efb2ee02mr8367550oab.11.1705342757399; 
 Mon, 15 Jan 2024 10:19:17 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 x28-20020aa793bc000000b006daed66b540sm7858505pff.219.2024.01.15.10.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 10:19:16 -0800 (PST)
Date: Mon, 15 Jan 2024 10:19:15 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Beniamino Galvani <b.galvani@gmail.com>,
 qemu-arm@nongnu.org, Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/2] hw/arm/allwinner-a10: Unconditionally map the USB
 Host controllers
Message-ID: <2cd5ba73-21f8-4e69-b5ff-a0c93dcb3095@roeck-us.net>
References: <20240115165615.78323-1-philmd@linaro.org>
 <20240115165615.78323-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240115165615.78323-2-philmd@linaro.org>
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=groeck7@gmail.com; helo=mail-oa1-x30.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, Jan 15, 2024 at 05:56:14PM +0100, Philippe Mathieu-Daudé wrote:
> The USB Controllers are part of the chipset, thus are
> always present and mapped in memory.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>

