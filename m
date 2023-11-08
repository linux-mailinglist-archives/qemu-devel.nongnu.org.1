Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC1B7E5ED2
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 20:46:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0oU1-00049B-19; Wed, 08 Nov 2023 14:45:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0oTz-00048p-0P
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 14:44:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0oTt-0006nc-T5
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 14:44:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699472691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TiNOHF2riEz6UmVbUdhrH0QqkAUwxYLlCuIqwfK+a64=;
 b=G/0NBNFrlABXmE9ByRiXBkoJ5Ws3OPzI0q0bM2obX6lS1ush2GMfmDpkcCSk3bVc/I9bYD
 DmwGY7Uwb1Bqoz61HoYy0BfjVXluMIpuaNeM/6Qh0Ix7EckKtBQGYVsEWrEH4mBH82pWyb
 IEZzdSyO1AQ0l5BKMjPrjdtZS09PCTs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-XOMm1lWFPH268Eg5HrOwWA-1; Wed, 08 Nov 2023 14:44:48 -0500
X-MC-Unique: XOMm1lWFPH268Eg5HrOwWA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c50bebd8dfso31681fa.3
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 11:44:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699472687; x=1700077487;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TiNOHF2riEz6UmVbUdhrH0QqkAUwxYLlCuIqwfK+a64=;
 b=GQBqu1OKHXudryJRF5Xf2YdHzWf2JDoHBLCCJe5ADXy23D5yz6gd1MzMjQk1zJ3xPm
 d6d0vblSimCyPOoStQKy72M3CQFmPs31DxpgwI0WSw3WQ9W1+rwUDOpgI28RmRC/zYgv
 b+cXFIsjAzAfYA5EX6YyxbbNjl8kHNIm8fs2ql/cX2ETVYq0atf3nouweEkKH37IhfZB
 RiXEZrwh1NiWBFBz3yMawusELmPvNCpTtwkIO6R9vgve1jq8aFzPltlzcbZhNmnmlKHS
 Ok+e5evn/dFmf3mWG7d03YXiDrtaMF9MXd3hM9IuiCPyWH8G9OXpR+69i6TcmpvGpnFy
 ojJQ==
X-Gm-Message-State: AOJu0YzoDYtXuUBmKrezQg/FO2UIYD8DZo49eUDJaz6GZ8aNqbxKyYLR
 c7Y4hWPO5Q/7wRVrom3OI57104TWt/diMt/VpcsEEG4rnZFl+Ooq+zA2SUdthGmvKlOUfzgu+zQ
 O1HW/KPMg2EnA+5w=
X-Received: by 2002:ac2:5b9c:0:b0:509:fc7:8853 with SMTP id
 o28-20020ac25b9c000000b005090fc78853mr1946726lfn.12.1699472687373; 
 Wed, 08 Nov 2023 11:44:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzWy8S8eAVbnGIGzj02OQzRv/EAm5Jxz40/i+CEPhEx+9lemAQpUd7VWsxySc507746JpsPw==
X-Received: by 2002:ac2:5b9c:0:b0:509:fc7:8853 with SMTP id
 o28-20020ac25b9c000000b005090fc78853mr1946718lfn.12.1699472686968; 
 Wed, 08 Nov 2023 11:44:46 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f5:d84:d31a:cf90:e9e6:cae3])
 by smtp.gmail.com with ESMTPSA id
 q12-20020ac24a6c000000b004fdd6b72bfdsm761855lfp.117.2023.11.08.11.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 11:44:46 -0800 (PST)
Date: Wed, 8 Nov 2023 14:44:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: qemu-devel@nongnu.org, David Woodhouse <dwmw2@infradead.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Joao Martins <joao.m.martins@oracle.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <lists@philjordan.eu>
Subject: Re: [PATCH v9 5/5] amd_iommu: report x2APIC support to the operating
 system
Message-ID: <20231108144325-mutt-send-email-mst@kernel.org>
References: <20231024152105.35942-1-minhquangbui99@gmail.com>
 <20231024152105.35942-6-minhquangbui99@gmail.com>
 <20231106193841-mutt-send-email-mst@kernel.org>
 <34300309-aa29-4a78-9e6b-aa91b05ff4af@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34300309-aa29-4a78-9e6b-aa91b05ff4af@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Nov 08, 2023 at 09:22:18PM +0700, Bui Quang Minh wrote:
> On 11/7/23 07:39, Michael S. Tsirkin wrote:
> > On Tue, Oct 24, 2023 at 10:21:05PM +0700, Bui Quang Minh wrote:
> > > This commit adds XTSup configuration to let user choose to whether enable
> > > this feature or not. When XTSup is enabled, additional bytes in IRTE with
> > > enabled guest virtual VAPIC are used to support 32-bit destination id.
> > > 
> > > Additionally, this commit exports IVHD type 0x11 besides the old IVHD type
> > > 0x10 in ACPI table. IVHD type 0x10 does not report full set of IOMMU
> > > features only the legacy ones, so operating system (e.g. Linux) may only
> > > detects x2APIC support if IVHD type 0x11 is available. The IVHD type 0x10
> > > is kept so that old operating system that only parses type 0x10 can detect
> > > the IOMMU device.
> > > 
> > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> > 
> > 
> > changes IVRS without updating expected files for tests.
> > result seems to be CI failures:
> > https://gitlab.com/mstredhat/qemu/-/jobs/5470533834
> 
> 
> Thanks Michael, I am preparing the fix in the next version. I've read the
> instructions to update the test data in bios-tables-test.c. It says I need
> to create some separate patches to update the test data. Are there any
> reasons for this? I intend to change the binary and include the ASL diff
> into the commit message. Is it enough?

No, not enough.  No, do not ignore the rules please.  Yes, there's a
reason.  The reason is that I need to be able to rebase your patches.  I
then regenerate the binaries. If the patch includes binaries it won't
rebase.


