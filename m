Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB6D7CADEA
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 17:43:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsPkd-0005RK-Kx; Mon, 16 Oct 2023 11:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qsPkc-0005Qy-1l
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:43:26 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qsPka-00076H-JA
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:43:25 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4066241289bso48183145e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 08:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697471002; x=1698075802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jGJEeIBNZqXkW0JTk9WOaffzn7/N73yrhYb7myE5emw=;
 b=M4mkZLXSS2Rn6DNChgam52HUFYxQOViAv7tbIdyfKXN4Q0j2V3pu6at76mFOtvCdkt
 pQJ+QHRhw+jHko0ywOlLNl/bVq9g/e2/SfvwhI2v1fI9qpUpaoBtmM+djBaRf3Y0LzG2
 8hIP1GGS/H7sRH0x/Y4lzPo3NYDzQyjYP7QH+NKROP86xCdCgvI8oGyqgXhDxJX4Q5PA
 sogSafDs4toOrcdfQG27QBjWgh9KJTD/a71Nu98kqjTVAmvAWL7n086qm77G6BT2nH4L
 bQqB9HEfSgwmnxrPSk8EASM61uy60pKV+RybY0HQOg0Zq+AbLDDomJsojFS31WIa9ZDj
 wxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697471002; x=1698075802;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jGJEeIBNZqXkW0JTk9WOaffzn7/N73yrhYb7myE5emw=;
 b=Cq/f9g/jEjKv5GdJjHpk8cbxmiYcipeuYatc1VFqfIVGPcxU8v54iKJoO44HwH2NVw
 gxuGsd3ABJq6cNPRPyBnGnixMGeYqtcOnTPqsYar1e2HC/Tv2e5EWhqF3RurYoGNZpdW
 2J8XSk56jxJZdAf98GC/EIeXQSEUvjhzkKrtEgKMFVusjWNI93HYNe4iCiD8IRbSKKNX
 drh+NhB97KHxIg1e60vuAWhFjYySaxZVtp25zhc6P5INq0pW68IsVMYSofTkJkdeveSO
 RxP+2R8djE+x4zEDQtj35cg0ztdyWOzV73MUoLRsF8P5A4ISQLriRyO2V12TJEdBM76A
 4rXw==
X-Gm-Message-State: AOJu0Yza5+R+1hMr18XOoCDLvTsHgcH8yFh+TTlNuEWKPcdUzbkemIOD
 aQL54VNtnyoAFzcCY4IpPLpKKA==
X-Google-Smtp-Source: AGHT+IFqsvEPS4ysRe6T6zdHkLo8uLeQI71re5z+QT/8atJfden9TisNeAB79W3kpTFvLCYS9kk+Mw==
X-Received: by 2002:a7b:c397:0:b0:401:b53e:6c40 with SMTP id
 s23-20020a7bc397000000b00401b53e6c40mr30688890wmj.10.1697471002686; 
 Mon, 16 Oct 2023 08:43:22 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u19-20020a05600c139300b0040651505684sm7499110wmf.29.2023.10.16.08.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 08:43:22 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C57651FFBB;
 Mon, 16 Oct 2023 16:43:21 +0100 (BST)
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
 <20231003183058.1639121-15-richard.henderson@linaro.org>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: fei2.wu@intel.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v17 14/16] monitor: Change MonitorDec.get_value return
 type to int64_t
Date: Mon, 16 Oct 2023 16:43:18 +0100
In-reply-to: <20231003183058.1639121-15-richard.henderson@linaro.org>
Message-ID: <87zg0ibmjq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

