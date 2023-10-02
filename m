Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BDC7B5D21
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 00:30:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnRPd-0001RB-Fu; Mon, 02 Oct 2023 18:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnRPa-0001Qo-TM
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 18:29:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnRPZ-0006uz-EA
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 18:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696285747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nduiLS9lqQy7ZqSQ5gX6+41FSV6dYiJO9S7PK0aSmdE=;
 b=PZUcIfWpT1bTX8J3DyBUeq/tG3fJjR8W/BLqXBxppvviylFdbB2e2/Ub+dAbytvBK/VrWi
 PyF4IDx6StoL68TqRj3jTQ3ErMBEYjFjhqSVaGV0YZzmo9WycDVz8gXTnkTqLP44Ush55R
 3Qcbtv7xdpvzZBQJCMQIDfDUR8ZYGfE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-Ve6yN5ZkND2OTpnG-uDjHA-1; Mon, 02 Oct 2023 18:28:56 -0400
X-MC-Unique: Ve6yN5ZkND2OTpnG-uDjHA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40647c6f71dso2035675e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 15:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696285735; x=1696890535;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nduiLS9lqQy7ZqSQ5gX6+41FSV6dYiJO9S7PK0aSmdE=;
 b=gvg2RMBqNCNVMQtiYb4460ENgYEIgxDxubMBP2UWMIZ9POLTE6Q2XNDP9wlzqN6Sdc
 ISBiwa8YfElQqPOEkqAtnUy+2nDEBc0g6x/Qrer7YNELjiEF6V9Rrw6AQ4Qat/1Af3gm
 0DYvzjxYuR++yMYK6vXZbS8l+KvTBsAh5z29r3HvI6xQXusuIEn7j4Zn1TDa9KWXkB1n
 2VlVkGn5UZ7Z4G081HIudoPHmLOOSVWPx0i8LhB03ULez+nHPGtcIaM0DXzkZHwITg+o
 1khKshkEZpww/lbjelUU7R1e8xkkq8xiFUMFxvdnbteHOG6FFNR4FBEwtvLP7RB/nP36
 rnTg==
X-Gm-Message-State: AOJu0Yz5kfOsIpu/cq/b9xkzq65uZv8k2ynSQJrvhsMnwLYRP35uhtAk
 9gYNOtXkmIHMq21Crrd/dWSyitF4YQpDrMVZlZui0EfFFTAm6IUFtUBcyzibAOwVMcTSqw5IXaG
 OBT2sWASj9NqwOeo=
X-Received: by 2002:a1c:f717:0:b0:402:e68f:888e with SMTP id
 v23-20020a1cf717000000b00402e68f888emr11743981wmh.4.1696285735181; 
 Mon, 02 Oct 2023 15:28:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnJuYCzLLdmL1sRcmRCaopVf/NZ5alZ2A2Bqnd1sglwicGxlQ6Pnj6ptv7zjo7E9v4WIgoaA==
X-Received: by 2002:a1c:f717:0:b0:402:e68f:888e with SMTP id
 v23-20020a1cf717000000b00402e68f888emr11743971wmh.4.1696285734821; 
 Mon, 02 Oct 2023 15:28:54 -0700 (PDT)
Received: from redhat.com ([2.52.132.27]) by smtp.gmail.com with ESMTPSA id
 n16-20020a7bcbd0000000b0040531f5c51asm8151247wmi.5.2023.10.02.15.28.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 15:28:53 -0700 (PDT)
Date: Mon, 2 Oct 2023 18:28:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH] pci: SLT must be RO
Message-ID: <20231002182836-mutt-send-email-mst@kernel.org>
References: <de9d05366a70172e1789d10591dbe59e39c3849c.1693432039.git.mst@redhat.com>
 <9cebce70-59fc-e7bb-5973-3091680b72ea@linaro.org>
 <42e00aaf-2399-4ba9-bef6-8627b8e0718e@linaro.org>
 <9f372453-4088-47d2-a501-c32eeaa5d9f5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f372453-4088-47d2-a501-c32eeaa5d9f5@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Oct 02, 2023 at 01:39:16PM +0200, Marcin Juszkiewicz wrote:
> W dniu 8.09.2023 o 15:29, Marcin Juszkiewicz pisze:
> > W dniu 31.08.2023 o 12:05, Marcin Juszkiewicz pisze:
> > > W dniu 30.08.2023 o 23:48, Michael S. Tsirkin pisze:
> > > > current code sets PCI_SEC_LATENCY_TIMER to WO, but for
> > > > pcie to pcie bridges it must be RO 0 according to
> > > > pci express spec which says:
> > > >      This register does not apply to PCI Express. It must be read-only
> > > >      and hardwired to 00h. For PCI Express to PCI/PCI-X Bridges,
> > > > refer to the
> > > >      [PCIe-to-PCI-PCI-X-Bridge] for requirements for this register.
> > > > 
> > > > also, fix typo in comment where it's make writeable - this typo
> > > > is likely what prevented us noticing we violate this requirement
> > > > in the 1st place.
> > > > 
> > > > Reported-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > 
> > > > Marcin, could you pls test this patch with virt-8.1 and latest?
> > > > Thanks a lot!
> > > 
> > > Tested-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> > > 
> > > sbsa-ref: PASS
> > > virt:     PASS
> > > virt-8.1: FAIL (as expected)
> > > virt-8.0: FAIL (as expected)
> > 
> > Can we get this patch refreshed and merged?
> 
> ping?
> 


yes, working on a pull request including this.


