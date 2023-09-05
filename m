Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D10E07928B9
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 18:46:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdZAI-0004rp-7z; Tue, 05 Sep 2023 12:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qdZAG-0004rc-RP
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 12:44:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qdZAE-0002Vg-JJ
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 12:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693932269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LWiNG9xo2MYcQ+ufwl/m6pBkdSlQtwXixbzbGN9VQrw=;
 b=jUxZk1Iky+J2SD4yTh4ybpixxcOsenG1YocAuUvP2ls5UDlkq+HUsbOlb+3jezAv2fmuxI
 Ye5DbztSiMq1J0Wb+QqnX0oeSYwQB07pAx0w0Whx+Ag2Gs3XA+aByZRERhfScEsFKJXhNb
 wPWOYUZNfzO+zU0+lyNr2AEmg1wsC60=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-KSKJpuszNBWJK9FO-1-kMA-1; Tue, 05 Sep 2023 12:44:27 -0400
X-MC-Unique: KSKJpuszNBWJK9FO-1-kMA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-500b95c69c3so2680584e87.1
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 09:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693932264; x=1694537064;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LWiNG9xo2MYcQ+ufwl/m6pBkdSlQtwXixbzbGN9VQrw=;
 b=XbR/o2uDlv3fKgNn7SMVZPYXfR33oUR7WWeqjC95OJ7GBaEqxOwwn4YTdNh7p0pB1D
 X6aXwoNH4lfBBRMeeOqjxXTEsxnIQkyGVRhB+0pvYfytDPKHSMx7jFV7W94NBMSrdg+H
 buFzJY54d3bHszaZDl6wNjf63Bh7NhPMdxhrS2c1O4MOKH5OA6IBXbOLzzp4zOpJ+iTU
 EZZ7355kgtXdEIxPnNVgj7y9u8JIMhlgQ9r5+3CjRbk7r4+RVp3cobraq3TPsFlChdnu
 lr9Y3wu0bk6RLNA23LWkmN74bvNpbnfKihQJwaykmrd9xAzG1WVO6bqxdZ7ZQ4ORHIG0
 4eEQ==
X-Gm-Message-State: AOJu0YzcxL6x+dxu6VwvqhogpKgBuSoM7ggpOZ+JFZ4kvirmkX8S4LFB
 ZJOvP+/MCUApNPDLAvvDFu6w7ZY8CjzBc9qAfau3+KpzmW5eddsOfAR3Dmlt6sfsGz5dSOGm7zo
 Vp3qMirGEpAynPXA=
X-Received: by 2002:a19:7710:0:b0:500:bd75:77d1 with SMTP id
 s16-20020a197710000000b00500bd7577d1mr242859lfc.63.1693932264620; 
 Tue, 05 Sep 2023 09:44:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXtMqpheYZgg1FLKcoyXCG3RwNTSuqoIqQ690AiFH7gNSW5WMtrcbAuYXGhMlrdrSpINvUlQ==
X-Received: by 2002:a19:7710:0:b0:500:bd75:77d1 with SMTP id
 s16-20020a197710000000b00500bd7577d1mr242845lfc.63.1693932264259; 
 Tue, 05 Sep 2023 09:44:24 -0700 (PDT)
Received: from redhat.com ([2.52.23.134]) by smtp.gmail.com with ESMTPSA id
 n13-20020a05640206cd00b0052a1a623267sm7307774edy.62.2023.09.05.09.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 09:44:23 -0700 (PDT)
Date: Tue, 5 Sep 2023 12:44:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marcello Sylverster Bauer <sylv@sylv.io>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, ani@anisinha.ca,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: PCI Hotplug ACPI device names only 3 characters long
Message-ID: <20230905123447-mutt-send-email-mst@kernel.org>
References: <66949448-1577-444a-b6d2-d907f9870765@sylv.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66949448-1577-444a-b6d2-d907f9870765@sylv.io>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Tue, Sep 05, 2023 at 05:05:33PM +0200, Marcello Sylverster Bauer wrote:
> Greetings,
> 
> I'm currently working on a project to support Intel IPU6 in QEMU via VFIO so
> that the guest system can access the camera. This requires extending the
> ACPI device definition so that the guest knows how to access the camera.
> 
> However, I cannot extend the PCI devices because their names are not 4
> characters long and therefore do not follow the ACPI specification.
> 
> When I use '-acpitable' to include my own SSDT for the IPU6 PCI device, it
> does not allow me to declare the device as an External Object because it
> automatically adds padding underscores.
> 
> e.g.
> Before:
> ```
> External(_SB.PCI0.S18.SA0, DeviceObj)
> ```
> After:
> ```
> External(_SB.PCI0.S18_.SA0_, DeviceObj)
> ```
> 
> Adding the underscore padding is hard coded in iASL and also in QEMU when
> parsing an ASL file. (see: build_append_nameseg())
> 
> So here are my questions:
> 1. Is there a solution to extend the ACPI PCI device using '-acpitable'
> without having to patch iASL or QEMU?
> 2. Are there any plans to change the names to comply with the ACPI spec?
> (e.g. use "S%.03X" format string instead)
> 
> Thanks
> Marcello


1.  All names in ACPI are always exactly 4 characters long. _ is a legal character
    but names beginning with _ are reserved. There's no rule in ACPI
    spec that says they need to follow S%.03X or any other specific format.
    I'm pretty sure we do follow the ACPI specification in this but feel free to
    prove me wrong.
2.  You can probably add something to existing ACPI devices using Scope().
    I would not advise relying on this - current names are not a stable
    interface that we guarantee across QEMU versions.
    If adding this functionality is desirable, I think we'll need some new interface
    to set a stable ACPI name. Maybe using aliases.


-- 
MST


