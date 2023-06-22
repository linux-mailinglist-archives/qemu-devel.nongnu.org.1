Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA1A73A985
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 22:34:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCQzd-0003Uj-SL; Thu, 22 Jun 2023 16:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCQzb-0003UB-E0
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 16:33:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCQzZ-0000de-8D
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 16:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687465999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nRbqvlBWYGumQVqwLV4mZShX8anD9CsIPAc+LWpKOSQ=;
 b=bzLjWvUEyTepnS+myHhqDM5sMHmcHnwYnJ7Cc2rxJCUQyeJtCjikiEXfbxnuntARiXN5pG
 WmqqF6jpf0YQxKs8D2wImKlM9opTx4bpyaWej9V4+GO/Uq6HX0VdgxPyuCNgj+Oe03EaBv
 42DYLiOfeDAOHZtTMcx8sS49rJHqx78=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-dt6R3BqkMBeu3w5SUKNbCw-1; Thu, 22 Jun 2023 16:33:14 -0400
X-MC-Unique: dt6R3BqkMBeu3w5SUKNbCw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f9b003507bso23396905e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 13:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687465984; x=1690057984;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nRbqvlBWYGumQVqwLV4mZShX8anD9CsIPAc+LWpKOSQ=;
 b=Qt6n7wY6L28dkeD5bgJrQdRqiM7Ui2SU1OHcfkcAG5xofbDTijqJcmtKVsq3qaoDnh
 Wh9nsk8ukTziIc2qzThKfdJM0jKHb3oFb7pr3KqFwH3yvkADJw2QRHEhcRi2vxO9jvVG
 fRfYkJZYpO3REycPeshpqLNByzZz7Z8vMfhcsFFlG7NQDAsmh9ecIeTNbfN48imQ9D4a
 iGbkkaofmom7O9MeqFEP0uKUyl0vIUlM1uPTIPkt2BkRydIOtSCg09h06AZYk9zdU10f
 x6IckuXsTrDzKnjxOHP4HzFC9zuVmG1TlGlFB+wP/k8jp71+DEigV9OXj2M/E9f8RHHh
 Iu6w==
X-Gm-Message-State: AC+VfDxTGXiN6h2ScarMDHs2JOFsuQSU0AemDSAVds5+T8+XHn3Yn51f
 +m9sFAzWp0bs2OoY+DjTx6lhpHXMf+zJZZiHDOBtaVac37nwSg+AcF0RczPFHEwRWvcJfgycO2N
 ztsol//kauHJHHpkee/Dejwc=
X-Received: by 2002:a05:600c:ad4:b0:3f9:b8b8:20df with SMTP id
 c20-20020a05600c0ad400b003f9b8b820dfmr6352012wmr.33.1687465984762; 
 Thu, 22 Jun 2023 13:33:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7zVqUGvFVUQHhKjuoyNvDc9j7dYda9gO8Gqp60QsLnKyeOi3cB1JMJMqmKIiPZYSbDlfkpAg==
X-Received: by 2002:a05:600c:ad4:b0:3f9:b8b8:20df with SMTP id
 c20-20020a05600c0ad400b003f9b8b820dfmr6352002wmr.33.1687465984435; 
 Thu, 22 Jun 2023 13:33:04 -0700 (PDT)
Received: from redhat.com ([2.52.149.110]) by smtp.gmail.com with ESMTPSA id
 e11-20020a05600c218b00b003f96d10eafbsm439765wme.12.2023.06.22.13.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 13:33:03 -0700 (PDT)
Date: Thu, 22 Jun 2023 16:33:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-trivial@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH 0/4] hw: Minor simplifications using proper QOM getter
 macros
Message-ID: <20230622163249-mutt-send-email-mst@kernel.org>
References: <20230523061207.48818-1-philmd@linaro.org>
 <78d99f7f-33f0-0007-10c7-c78278cde080@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78d99f7f-33f0-0007-10c7-c78278cde080@tls.msk.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Jun 08, 2023 at 09:41:58PM +0300, Michael Tokarev wrote:
> 23.05.2023 09:12, Philippe Mathieu-Daudé wrote:
> > Enforce QOM style. Besides, using the proper QOM macros
> > slightly simplifies the code.
> 
> Applied to my trivial-patches branch (Maybe it's time to resurrect it).
> 
> Thanks,
> 
> /mjt

pci things:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


