Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B3473B0FD
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 09:00:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCamC-0006tP-JD; Fri, 23 Jun 2023 03:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCalx-0006sJ-0E
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 02:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.145.221.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCalu-0003xp-7j
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 02:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687503592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n5FfHalw8xCTw9CMZhOOuU7kD3v6HXxUzJ0PHEjZOUY=;
 b=TO1W+IUofb7kG3KiXO0nk1q0ys0PRLrfn3pAEWLI6bAtdYiRsrDPytRo10QO7HUJZRI+Dt
 uLAwOsbMb2c1dPOfqkfEpNCYW+Bhij3FiL4aaeUmcjJHSu6/28Bjn5cByw6yQsy4eJDK0H
 TeVXlTzb5fwwqEfUyElUrBuifN7/m8Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-fJAXbO2RPCWVwxMb7U0nrA-1; Fri, 23 Jun 2023 02:59:49 -0400
X-MC-Unique: fJAXbO2RPCWVwxMb7U0nrA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fa7a851dadso2270055e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 23:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687503589; x=1690095589;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n5FfHalw8xCTw9CMZhOOuU7kD3v6HXxUzJ0PHEjZOUY=;
 b=TqLg0rDnFrtxryqWNhV7Uu8+VWwFaPhy397cv4kAjJ+2AdpNDEENHJWVd7b3NUO+mq
 oHksDVKLvHrBL+XrXEzYqqtfwrBT2amu6F3S+17sQLDfdK8qnTI97n2JRls2pvH4ioEY
 7oPU7DYYcDb/FY05SUS2bw6U2Wqufa4JoFjVcUuQp8M/gbFyO7MByIKQxRwQu1Jot6El
 jTNF7jyOa6Z4ojJvHYhHc/Gqm29hsoccVAmWxJQyHRYUoPhUARdKw+O/6FTpU7gy0gbd
 m1apFT4xfOdX2nXymh6uoLYhFxUcACPDqT74RxuXA0iM9bpHnznSOBj5FiLmlVZupTPF
 IIUA==
X-Gm-Message-State: AC+VfDxd49xUV+Bc2aCYt7oqHZqp5cTfh+qggWR+MEFRSah8mg+1e4BI
 m91QB0dNF2AjRNZPLsxiftJHUJy5AKLjWi1YDIxUs1m5nYBRzgUlndrHi22lsyOAybh6ZjuY4UG
 ncl5TaK1G1YHDDK4=
X-Received: by 2002:adf:ec03:0:b0:306:36ef:2e3b with SMTP id
 x3-20020adfec03000000b0030636ef2e3bmr15881821wrn.70.1687503588888; 
 Thu, 22 Jun 2023 23:59:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6nS1FyyFtV/ouSSfRPSckt6bSMMjXNJzEuCHNDMJ/MHr/jQsx6YJ4qf3iXhfMVYInxKAypyA==
X-Received: by 2002:adf:ec03:0:b0:306:36ef:2e3b with SMTP id
 x3-20020adfec03000000b0030636ef2e3bmr15881810wrn.70.1687503588618; 
 Thu, 22 Jun 2023 23:59:48 -0700 (PDT)
Received: from redhat.com ([2.52.149.110]) by smtp.gmail.com with ESMTPSA id
 y14-20020a5d470e000000b0030647449730sm8872184wrq.74.2023.06.22.23.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 23:59:47 -0700 (PDT)
Date: Fri, 23 Jun 2023 02:59:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>,
 linux-cxl@vger.kernel.org, linuxarm@huawei.com,
 Ira Weiny <ira.weiny@intel.com>, Michael Roth <michael.roth@amd.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Dave Jiang <dave.jiang@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v8 0/4] hw/cxl: Poison get, inject, clear
Message-ID: <20230623025836-mutt-send-email-mst@kernel.org>
References: <20230526170010.574-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526170010.574-1-Jonathan.Cameron@huawei.com>
Received-SPF: permerror client-ip=216.145.221.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_FAIL=0.001, SPF_HELO_NONE=0.001,
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

On Fri, May 26, 2023 at 06:00:06PM +0100, Jonathan Cameron wrote:
> v8: Formatting fixes for QMP docs from Markus Armbruster (thanks!)

This and other patches add a bunch of over-80 chars lines.  I'm not
going to intervene here as cxl has lots of them but maybe scan over cxl
codebase and shorten where appropriate.
Thanks!

-- 
MST


