Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF85378D096
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:28:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nv-0001pB-4f; Tue, 29 Aug 2023 19:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qb5c1-0000Ep-RY
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:46:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qb5bx-0007Rm-H4
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693342012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u069NO16WAovdX6uXScjF018D+J+6wwITMqmSeb6se0=;
 b=aFYIUu6XytfZu2hMSA8/RVYTktt7RTQar4ver56p5t9IK90SBAb/f1aYMIOLQxlN/JsfvD
 fyVvB6lHyDePsnTaNai6ncCUA5JWMzuxfw0qoFxkbuzVoQT+EegWxmiINyZX/crWtwkhIM
 dl/pGWu0A7vAz6sTc19yKL3tOSzCVVg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-8xMw03aSPb6jBojNzrVeZw-1; Tue, 29 Aug 2023 16:46:49 -0400
X-MC-Unique: 8xMw03aSPb6jBojNzrVeZw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-52a08d02c62so3791005a12.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 13:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693342009; x=1693946809;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u069NO16WAovdX6uXScjF018D+J+6wwITMqmSeb6se0=;
 b=Mn8QWQ9HCBeiVTrwHmOQACKcGYFDdgBkFPmdNQTj4fCqyqoqcGDBgNHVr2doxCcqQg
 VPv3ByOrV4DX4b43+sH56LunXoTcpPvjjb9crsNIHcLbWpjkxRlSL+kaDM/3O6ZsV8Zg
 6huTSQ89zuGmB4WYnLFmzULmC6qr6u0kUJLC2t+SSVtGU16T4oNT4l98R0NUAYBLmf54
 b6ZrsomDbNH0xHg4JGd32/FzaiTQQz4JgxxfjZ0/IJ3J769w1GncFKdZi9t3JFnLeB4R
 vvKfITyqtovZ6ESJRTiycw8ujSqXfIwpK5InlYmVD+fVSzbscwgsyMrFZ5SISrhbE/Bf
 yKUg==
X-Gm-Message-State: AOJu0Ywg0o38Ed9Krfrt8bMGaJp7Vtydu6q2D1oFf3NMq4sGgLMo1iTM
 /6uf/UbW5jlIUmAVtvE/+cYvVvljMv0QazR5nTJmpKCH4A0qWT5BLsO3d6e/Vn+sjVZOZ35tSxE
 lymn1jezMRLwh/H0=
X-Received: by 2002:a17:906:5da5:b0:9a1:e8c0:7e2e with SMTP id
 n5-20020a1709065da500b009a1e8c07e2emr110748ejv.14.1693342008853; 
 Tue, 29 Aug 2023 13:46:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFneXcp9+Bc6gcDHsItGiDGgBRWa0KrpV1j2Ohfrq+8vMdDEp4v5w72+h3Yh6pbbCMHBBsh/g==
X-Received: by 2002:a17:906:5da5:b0:9a1:e8c0:7e2e with SMTP id
 n5-20020a1709065da500b009a1e8c07e2emr110736ejv.14.1693342008505; 
 Tue, 29 Aug 2023 13:46:48 -0700 (PDT)
Received: from redhat.com ([2.55.167.22]) by smtp.gmail.com with ESMTPSA id
 k11-20020a1709063e0b00b009a1a653770bsm6303208eji.87.2023.08.29.13.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 13:46:47 -0700 (PDT)
Date: Tue, 29 Aug 2023 16:46:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Gowtham Siddarth <gowtham.siddarth@arm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: PCIe: SLT attribute mismatch: 0xFF020100 instead of 0x20100
Message-ID: <20230829164638-mutt-send-email-mst@kernel.org>
References: <56aa4acb-d54c-a457-5a32-9258cec1ac96@linaro.org>
 <CAFEAcA81xq_yEXYdtAXtkqcdR=MHagSNf5rXOtt+AwohMY_=BQ@mail.gmail.com>
 <20230829093909-mutt-send-email-mst@kernel.org>
 <43653986-c04f-0076-637b-9061f9702f77@linaro.org>
 <20230829130617-mutt-send-email-mst@kernel.org>
 <ff230439-5d76-1f50-a25a-1fd666c3f369@linaro.org>
 <20230829161732-mutt-send-email-mst@kernel.org>
 <601619fb-5f1e-4b93-3dd1-b415d0ee8979@linaro.org>
 <20230829163929-mutt-send-email-mst@kernel.org>
 <fd3665ae-da56-9d86-ff91-b1efa107671b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd3665ae-da56-9d86-ff91-b1efa107671b@linaro.org>
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

On Tue, Aug 29, 2023 at 10:44:08PM +0200, Marcin Juszkiewicz wrote:
> W dniu 29.08.2023 o 22:40, Michael S. Tsirkin pisze:
> > > It passes with sbsa-ref (which is not using QEMU versioning).
> > > 
> > > Fails (as expected) when used new property for each pcie-root-port
> > > (ignore line breaks):
> > > 
> > > "-device pcie-root-port,
> > >    x-pci-express-writeable-slt-bug=true,
> > >    id=root30,chassis=30,slot=0"
> > 
> > could you also check with -machine pc-q35-8.1 instead of this
> > property?
> 
> BSA ACS is AArch64 only.

virt-8.1 then


