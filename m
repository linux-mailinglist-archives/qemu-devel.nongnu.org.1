Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9127F7A3A
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 18:18:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Znp-0002Ae-SE; Fri, 24 Nov 2023 12:17:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r6Znn-00021L-Rg
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 12:17:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r6Zni-00081i-8N
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 12:17:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700846228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TjvOfBBy3CB1xDCiGei6x+xk0Ap+v5S7gV9mrBinp1E=;
 b=GB0Z2k1Utf6p5ynvLAnj33phRzVp/e85fs7WTS70UpzZ/sWE6HfBJnVOcgf0Qih1dd+q2n
 EhCT4ah6oww3o3e1EhdWfed7zlOf0D5CglOHztgaXLpFCn3sTBpCS5AD52y2Hn8u141zyX
 knOSlquSaJVe2VHmd9x4B+XUHbw3gsc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-ZXJfU7l6MiKgfuyUJ9K5GQ-1; Fri, 24 Nov 2023 12:17:07 -0500
X-MC-Unique: ZXJfU7l6MiKgfuyUJ9K5GQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-77d78b44f19so221068785a.3
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 09:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700846225; x=1701451025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TjvOfBBy3CB1xDCiGei6x+xk0Ap+v5S7gV9mrBinp1E=;
 b=OA+aD66OtSbdRRzhAdx/EGaZzbKQt6Q9qU+o73k/Beg/q2dj33NOI0SXpSWUryjY8O
 9d1TcvRP+GhEY0Rrwq302xmkE0Oqu5sOC1n3jiol3ikLoPjQxycAeDihqe62p/iQZWwW
 ijvSipkR+RwQIknFOUWOinOwy21EFnVXy9DBQkLj/POC57u8NzpW0GZvvimouV4rg1fl
 r7JuzEkfZhPxx6YeOi/zPwKRWFTJIkPKGKdHOd+HGiFUGlNRwvYcc5/VYWtjeTtxWsmG
 ZuCM/+fDN9+7LEynDzBFW4ASQwYUTtJkGtbPKMpBMNtQWft2R5FF3khSIOmujpE8/fJj
 aH+Q==
X-Gm-Message-State: AOJu0Yxv7+vN7T4vbp/aJC4edxQK5Ba56Z30iLGZ/KO2E0kimzIisIH9
 NXDJK5QxvAXDRoKXV58JA3O9aQHNkF9BMgsvdNUuNtuRILdzdo4t9zVqdi0Pe3t5xLISkcTV18w
 sRBAUKHlmECcnI/A=
X-Received: by 2002:a05:620a:8414:b0:77b:b1d2:9586 with SMTP id
 pc20-20020a05620a841400b0077bb1d29586mr3527035qkn.39.1700846225755; 
 Fri, 24 Nov 2023 09:17:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNesQzYLJKFZiyinz09n2oNYv4fFJNEGPwMudxpsDXtL4w4bTxiWWGo9qyvp/IBJ3Dz/Q4SQ==
X-Received: by 2002:a05:620a:8414:b0:77b:b1d2:9586 with SMTP id
 pc20-20020a05620a841400b0077bb1d29586mr3526991qkn.39.1700846225505; 
 Fri, 24 Nov 2023 09:17:05 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com ([185.140.112.229])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a05620a261100b0077d85b1d45dsm226840qko.72.2023.11.24.09.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 09:17:05 -0800 (PST)
Date: Fri, 24 Nov 2023 18:16:58 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <maz@kernel.org>,
 <jean-philippe@linaro.org>, <jonathan.cameron@huawei.com>,
 <lpieralisi@kernel.org>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <andrew.jones@linux.dev>,
 <david@redhat.com>, <philmd@linaro.org>, <eric.auger@redhat.com>,
 <oliver.upton@linux.dev>, <pbonzini@redhat.com>, <mst@redhat.com>,
 <will@kernel.org>, <gshan@redhat.com>, <rafael@kernel.org>,
 <alex.bennee@linaro.org>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>,
 <zhukeqian1@huawei.com>, <wangxiongfeng2@huawei.com>,
 <wangyanan55@huawei.com>, <jiakernel2@gmail.com>, <maobibo@loongson.cn>,
 <lixianglai@loongson.cn>, <linuxarm@huawei.com>
Subject: Re: [PATCH V7 0/8] Add architecture agnostic code to support vCPU
 Hotplug
Message-ID: <20231124181658.4385fdac@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231113201236.30668-1-salil.mehta@huawei.com>
References: <20231113201236.30668-1-salil.mehta@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, 13 Nov 2023 20:12:28 +0000
Salil Mehta <salil.mehta@huawei.com> wrote:

[...]
>   physmem: Add helper function to destroy CPU AddressSpace
>   gdbstub: Add helper function to unregister GDB register space
[...]

above patches look like potential bugfixes (modulo they aren't getting used actually),
only commit messages do not mention adverse effects (which they should do).

Question is:
    do un-destroyed/registered CPU AS and GDB RS affect machines that
    already support cpu hot-unplug? (x86/s380/spapr)


