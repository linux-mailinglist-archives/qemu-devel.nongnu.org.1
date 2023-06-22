Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAF473A954
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 22:08:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCQZu-0004BY-MD; Thu, 22 Jun 2023 16:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCQZr-0004BF-TR
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 16:06:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCQZq-0003W0-CP
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 16:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687464405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JZZ9JjdoHR+znLDebyfX+wIlXBjNbT70BYRaKypGddI=;
 b=Sl/cGStZsqSV8Oyg/lJjpRGrXXgGhno2cLTY4s4MZzCj3Np6GRNFS13Aqr2cKqB8OULl4S
 xKxbXFqt1qY1eI0ovPqT/EVrkSOr6FdJCZbVeu1Y+OHJi85+YR7bmz8oNjWs2xpDFsBAQH
 Lit9Rw2MadeiwcjFt34G0beD8am8hfI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-2-BBiRV7OsyFgUZo0hzEZg-1; Thu, 22 Jun 2023 16:06:38 -0400
X-MC-Unique: 2-BBiRV7OsyFgUZo0hzEZg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f9b5cc7298so18348515e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 13:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687464392; x=1690056392;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JZZ9JjdoHR+znLDebyfX+wIlXBjNbT70BYRaKypGddI=;
 b=Ae3B7dQmNje0ueADuHueppkK0FqEYQKc9potqLvLb4ks9iKpfwnha9iJSBYPT5fgNe
 igLJKc5GurmT62HBvVdPgrgD0au8IkhneyekQO3MsThODYjmD9+mA7dwPMn1CKZSmhmu
 aORrFJJPZw8OnTibDi4C3eQOM0SfRj1MJSUsG2fT9WrfxpaXxN6qgzPOQsVa6c5+v4tt
 +TbHVesrGJQapud5gWs4k2OoaYWB3iONEYv/dYos5UcR/7p2Uyzk1TjUuXVGhhrGZoR3
 cfG5ktkjlwegNOewp08Kj8xSF0EkTLbQQ/hShBifPck6CrN/7T6vPksfNfCXQa2CNvPk
 ws6w==
X-Gm-Message-State: AC+VfDx5UPrlO1SAm4UB6aD7hR4Fc9rvl0QysvekV2fIMyjwtn04nBxm
 uOskvbY4ZonWsZnxQcVmSka8S+L0jZkusKOyvvBNxI0kWKYhDPLvcB1Q9BjyY9z7k38750/J5x9
 7Hn0QpkAb25cDHIY=
X-Received: by 2002:a7b:cbd3:0:b0:3f9:b3ec:35d0 with SMTP id
 n19-20020a7bcbd3000000b003f9b3ec35d0mr7497165wmi.10.1687464392551; 
 Thu, 22 Jun 2023 13:06:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7rlWAO0UCevKHIljLvYL1MihIjVvKH+uXF3xKViaweSkl0GSzIFuP1drVD+x6jiQNGPOaoeg==
X-Received: by 2002:a7b:cbd3:0:b0:3f9:b3ec:35d0 with SMTP id
 n19-20020a7bcbd3000000b003f9b3ec35d0mr7497156wmi.10.1687464392284; 
 Thu, 22 Jun 2023 13:06:32 -0700 (PDT)
Received: from redhat.com ([2.52.149.110]) by smtp.gmail.com with ESMTPSA id
 p9-20020adfcc89000000b003113f0ba414sm7771433wrj.65.2023.06.22.13.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 13:06:31 -0700 (PDT)
Date: Thu, 22 Jun 2023 16:06:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 0/4] tests/qtest: Check for devices before using them
Message-ID: <20230622160436-mutt-send-email-mst@kernel.org>
References: <20230525081016.1870364-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525081016.1870364-1-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 25, 2023 at 10:10:12AM +0200, Thomas Huth wrote:
> Here are some more patches that are required for running the qtests
> with builds that have been configured with "--without-default-devices".
> We need to check whether the required devices are really available
> in the binaries before we can use them, otherwise the tests will
> fail.
> 
> Thomas Huth (4):
>   tests/qtest/usb-hcd-uhci-test: Check whether "usb-storage" is
>     available
>   tests/qtest: Check for virtio-blk before using -cdrom with the arm
>     virt machine
>   tests/qtest/rtl8139-test: Check whether the rtl8139 device is
>     available
>   tests/qtest/usb-hcd-ehci-test: Check for EHCI and UHCI HCDs before
>     using them
> 
>  tests/qtest/bios-tables-test.c  | 2 +-
>  tests/qtest/cdrom-test.c        | 6 +++++-
>  tests/qtest/rtl8139-test.c      | 4 ++++
>  tests/qtest/usb-hcd-ehci-test.c | 5 +++++
>  tests/qtest/usb-hcd-uhci-test.c | 4 +++-
>  5 files changed, 18 insertions(+), 3 deletions(-)

I am worried that if an uninitentional change disables some devices
by default our CI will no longer catch this.
Any way to address this? E.g. maybe introduce a "for CI" or
"test all" configure flag and then make test fail if something
hasn't been configured?

> -- 
> 2.31.1


