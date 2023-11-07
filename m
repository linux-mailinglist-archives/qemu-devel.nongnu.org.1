Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 622E67E386C
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:08:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J0d-000847-LS; Tue, 07 Nov 2023 05:08:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J0b-00083I-26
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:08:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J0Z-0001yE-Je
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:08:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eftHBmFdQ6rCY7P02LDmKGBkG1Er/ZcvebyCL7XFRyw=;
 b=cNgB1hQEm9zKdLy20mzfppbw/QcPGCHt2RnTxQwlcp1YVd3OEN9XEo9k3qY6q10MSWpGJj
 ZC3CJjxBLNWN0e+yBLLQzEnXkgv7SIfzd0KEOfoNkLGHKIGuAzhbrpSuHa6/7pBzhMd5qD
 LJbAt2syVaIpYrWzTGQRmDm+/MV4no4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-TDZe99IQOkaWmooBScd3VA-1; Tue, 07 Nov 2023 05:08:27 -0500
X-MC-Unique: TDZe99IQOkaWmooBScd3VA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4084001846eso36183835e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:08:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351706; x=1699956506;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eftHBmFdQ6rCY7P02LDmKGBkG1Er/ZcvebyCL7XFRyw=;
 b=RrdZRlhBQw3WlmzzSdpYxN516XMv+zMCpEdMNnkQZu483Qvm39kBecr7/3fcvKJLRd
 2t3rM3Xbg5RGtyCwLYwxkd/1Wj/F3W1LVr4l6Ica7Aq/HNnH0HE3udxonRa3UJZJsWBO
 kHE7opn8gbOpyXWFUZ7S2/JE1uy6DWaNNB+hxUGknj/yMMAxYbAlLtwDyY0NlgwNth20
 +zwsVBCH1CZdRuAdP7W4HA4/EeOY3SltM3Dpos0APPraGnZdKiojWDQ68BTiKAlnXYle
 Ed/OD+5IFR09+QL2Sdyr0Wcpy1yK/wgSdG4ymtHrXDGm6G3WiBj2SplhgW3wWAvgpT+N
 8BNA==
X-Gm-Message-State: AOJu0YxURFcLXJ1YRGGO6gR2zqKGRmhZm4S7lH73sHrxx+0eS9PETRRs
 4MQy0LvCch3SMCh4xRg6kWlAg4KVx4jAAg4XxNEbPnfnZRF+5fFYL5BBKhRT36XDQk+qiGjgZLu
 E2+gwIiop9MlBLto=
X-Received: by 2002:a05:600c:1f90:b0:407:5b54:bb15 with SMTP id
 je16-20020a05600c1f9000b004075b54bb15mr1748396wmb.36.1699351705956; 
 Tue, 07 Nov 2023 02:08:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtLvvy1lb4YCMN/4QbfcBgXk5ElDORFhwBd1qzQ7xW2AUcLs1B9deEPcqPa3/IRajDFO1cww==
X-Received: by 2002:a05:600c:1f90:b0:407:5b54:bb15 with SMTP id
 je16-20020a05600c1f9000b004075b54bb15mr1748388wmb.36.1699351705668; 
 Tue, 07 Nov 2023 02:08:25 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 v2-20020a05600c428200b0040303a9965asm14822459wmc.40.2023.11.07.02.08.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:08:24 -0800 (PST)
Date: Tue, 7 Nov 2023 05:08:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 Michael Tokarev <mjt@tls.msk.ru>, linuxarm@huawei.com,
 Fan Ni <fan.ni@samsung.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Gregory Price <gregory.price@memverge.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Klaus Jensen <its@irrelevant.dk>,
 Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH v2 00/17] QEMU: CXL mailbox rework and features (Part 1)
Message-ID: <20231107050731-mutt-send-email-mst@kernel.org>
References: <20231023160806.13206-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023160806.13206-1-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

> This series is focused on enabling the Fabric Management aspects of
> CXL to enable orchestration and tooling development and also
> to enable testing of related kernel features.

This would be a better subject than "CXL mailbox" then ;)


