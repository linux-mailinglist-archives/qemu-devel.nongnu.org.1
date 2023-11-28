Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 549447FBECC
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 17:01:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r80Vx-0001Cu-CK; Tue, 28 Nov 2023 11:00:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r80Vv-0001Cd-4J
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 11:00:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r80Vs-0001Hg-BO
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 11:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701187239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wJML4nf/vf6WMt7bC7V5bJTqhaiWi8DMM/WpaGrrByo=;
 b=d9S5IJeTq5l+g6KapYEJG4pMRqQbbYy6u1I6RV3G6XVinDwVRjEPvkzEVzJO0glapWah7n
 MSWIBWvFSGiGC0uD/Al9oaFO2lBAg0T30UCIVBbtEgbTKRfOWrbvCB5wh/jfJ+O2q9pmYS
 NU7FhXSvTTpA7P0nqpAasClcXDKim5c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-huYkIW6mOf6yX1PWCiRb7g-1; Tue, 28 Nov 2023 11:00:38 -0500
X-MC-Unique: huYkIW6mOf6yX1PWCiRb7g-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40b310b5453so37790095e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 08:00:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701187236; x=1701792036;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wJML4nf/vf6WMt7bC7V5bJTqhaiWi8DMM/WpaGrrByo=;
 b=FZk/Q5IhTnATeWO1SQ3in3O/aqUj9cVz/xw/LFEy+H8HbQ8LmwyiuJ8BpClagS1fEs
 SKf1jB3zussRvQ+88+biE14IytU+2dvs8VAKf8mKWxZp/pdzDnrlpjwvtj7UP54C7kJk
 VOfy4CTiVm2rBiy+5EaD2rzWCKKAQxjs71OrP0mV1b9LQECXTTBQA9MOObz7ZWnUEgur
 +z+PG7u/QwAue0yEJrjsiuRswxq5g79lQ9jff6tiJtl17jlLqOADWgtfHTXMU/fyIj8Z
 Ty3xtTyMdC/SKRl4dcIwugGiuZsNQJKjZaQlfxXxzjKX+jcJE8v9ihESrIllxHS1r9v8
 VmOg==
X-Gm-Message-State: AOJu0YwPhwbzMt4f93NhgVscYbysu4kVWmOzYADUW7Yz1ghsEUbWzxNI
 9VWrr685ZHN+Pkn3rcPv+zkr7Ibr50bbN+lzQruKBjr4sE4L9OR4FK28JMmTpnjMDmMZrP9P+Du
 BWI1g2MD3nglCbxg=
X-Received: by 2002:a05:600c:3104:b0:406:8496:bd8b with SMTP id
 g4-20020a05600c310400b004068496bd8bmr8779250wmo.9.1701187236636; 
 Tue, 28 Nov 2023 08:00:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFewBSc67cRxhtTKrpp1n6nmsfhHOYtnI58FQ2VjZymersc5OZ9FmB6Twx+eRbEcmPicORg7g==
X-Received: by 2002:a05:600c:3104:b0:406:8496:bd8b with SMTP id
 g4-20020a05600c310400b004068496bd8bmr8779214wmo.9.1701187236198; 
 Tue, 28 Nov 2023 08:00:36 -0800 (PST)
Received: from redhat.com ([2a02:14f:16e:d9ab:fea6:e6c9:5c46:ef63])
 by smtp.gmail.com with ESMTPSA id
 v21-20020a05600c471500b0040a4751efaasm17907662wmo.17.2023.11.28.08.00.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Nov 2023 08:00:35 -0800 (PST)
Date: Tue, 28 Nov 2023 11:00:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: Re: [PULL 31/53] hw/i386/pc: Default to use SMBIOS 3.0 for newer
 machine models
Message-ID: <20231128105920-mutt-send-email-mst@kernel.org>
References: <cover.1687782442.git.mst@redhat.com>
 <59c230dab17176f798fb938ba4318543d9cf31d8.1687782442.git.mst@redhat.com>
 <bb7a62d4-886b-4887-94f7-c41659bfc6f6@proxmox.com>
 <ZWX1n7OWh81Dd2tJ@redhat.com>
 <76e8060f-ad71-4aa7-a675-baa735c9c2f2@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76e8060f-ad71-4aa7-a675-baa735c9c2f2@proxmox.com>
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

On Tue, Nov 28, 2023 at 03:53:21PM +0100, Fiona Ebner wrote:
> Am 28.11.23 um 15:13 schrieb Daniel P. Berrangé:
> > On Tue, Nov 28, 2023 at 02:57:17PM +0100, Fiona Ebner wrote:
> >> we received some reports about the new default causing issues for
> >> certain guest OSes [0][1]. Namely, for Juniper vSRX, where boot fails
> >> and Microsoft Windows, where querying an UUID set via QEMU cmdline
> >> -smbios 'type=1,uuid=a4656bd0-a07d-48e0-9dfd-bdc84667a8d0'
> >> in Powershell with
> >> get-wmiobject win32_computersystemproduct | Select-Object
> >> -expandProperty UUID
> >> doesn't return any value anymore and can trip up some guest
> >> applications. The original report is about Windows 10 and I reproduced
> >> this with Windows Server 2019 and the German (but I hope it doesn't
> >> matter this time) version of Windows Server 2022.
> >>
> >> Using machine type 8.0 or the machine option smbios-entry-point-type=32
> >> are workarounds.
> >>
> >> Since Windows is widely used, that seems a bit unfortunate. Just wanted
> >> to ask if you are aware of the issue and if there is something else that
> >> can be done other than specifying the more specific machine commandline
> >> for those OSes?
> > 
> > I don't recall seeing this issue mentioned before. Could you file a
> > bug at https://gitlab.com/qemu-project/qemu
> > 
> 
> I made one for the Windows issue:
> https://gitlab.com/qemu-project/qemu/-/issues/2008
> 
> It's not clear to me if this is a bug in QEMU or just a bug/limitation
> of the guest OS when 64 bit entry is used by SMBIOS.
> 
> I didn't create one for vSRX, because I'm not using it myself and since
> it's based on FreeBSD and FreeBSD 13.1 can boot just fine with both 32
> and 64 bit entry, it might be an issue on their side.
> 
> Best Regards,
> Fiona

I would be inclined to limit this to when we have too many VCPUs then.
Igor WDYT?

-- 
MST


