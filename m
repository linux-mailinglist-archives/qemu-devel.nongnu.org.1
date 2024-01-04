Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3770D823D30
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 09:09:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLIlg-0006Bh-9Q; Thu, 04 Jan 2024 03:07:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLIle-0006BQ-A6
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 03:07:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLIlc-0003Dm-I0
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 03:07:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704355671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fz43dLURe+aIgByZHhAeuVay3evlBrH8cX/y6E0JvAY=;
 b=QM61IwYxUT3VP/jDOlC66vvN2S2bH4bNZo+sTqcwUEHQIkG4LEgdXmCfxTfa8y1/4npqog
 3IpkVvqFq/QSwt44d3DYtuHXC/dBgBVuomvktaORDjJ1mpgVIJZvPXCSijKvim2pzZwJTA
 o1McOJFpT8Cf1VipZPhbJWASr3Q/q9k=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-meehEACVOOanpifl6GrSlg-1; Thu, 04 Jan 2024 03:07:49 -0500
X-MC-Unique: meehEACVOOanpifl6GrSlg-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1d44a50ab19so680005ad.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 00:07:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704355669; x=1704960469;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fz43dLURe+aIgByZHhAeuVay3evlBrH8cX/y6E0JvAY=;
 b=lHfefv1OMs8QLSDW8GCey/0lSrSd/g0iBFt/I2C97V8sZXyI0r71g+hahwsUu0PYPq
 H0Jtv4SGLzMm208ScP1BRxSRZgottZoVaWnqNPX95e+0UMZlYN0kswhZYutRKLv3oUpG
 R2HfUtw7lgC4D+fsiUFYCYWA3rKy4onQojXMRVJ5o4Ce2KE4hYyoZXJUJSR7Pl+8Oz8W
 hifDBESiS2MG0+574eDOpw6SVJjm0ac4LJumiG4J/us4sYhux2BpmFmJ4JjS3SZ6Om5N
 70DPBqRUJJSXCopT5VzrZHPgtW5gkdczANj0gNfMKRaPI9BwwGN+i/OVEaA04IyrK56V
 aIBA==
X-Gm-Message-State: AOJu0YzwG2GoQbP7IcfXcwh776LtCLbvEa6MH1jzqlHh0kEV/TwWyH3D
 xC0MAHRFYsq+yjHM+3SZdoB19WCL2OIzT//EkP7nze+ZDvE5ffzxzUVharNEHFZ5Ime/jNlZypg
 sLKirDR0oGNxSLs6QTQS0yEo=
X-Received: by 2002:a17:902:dac1:b0:1d3:7788:1c40 with SMTP id
 q1-20020a170902dac100b001d377881c40mr398758plx.0.1704355668859; 
 Thu, 04 Jan 2024 00:07:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEpFzAoSO64fGtgB3NWMxr2CI0MvqFa6Otg0/FaeGx3uDNgNPVZaRMt/7/2p1SpkdUXkzOXg==
X-Received: by 2002:a17:902:dac1:b0:1d3:7788:1c40 with SMTP id
 q1-20020a170902dac100b001d377881c40mr398746plx.0.1704355668545; 
 Thu, 04 Jan 2024 00:07:48 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 s2-20020a170902c64200b001d075e847d5sm25158021pls.44.2024.01.04.00.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 00:07:48 -0800 (PST)
Date: Thu, 4 Jan 2024 16:07:42 +0800
From: Peter Xu <peterx@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 prerna.saxena@nutanix.com, berrange@redhat.com,
 peter.maydell@linaro.org, armbru@redhat.com
Subject: Re: [PATCH] migration: Simplify initial conditionals in migration
 for better readability
Message-ID: <ZZZnTmVxn4tha1qL@x1n>
References: <20231205080039.197615-1-het.gala@nutanix.com>
 <87a5qon6vj.fsf@suse.de>
 <62ae7ae7-76bd-4526-a002-515cd9660ed4@nutanix.com>
 <0db9854c-4e4f-4f2a-a143-16d3ca62f44a@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0db9854c-4e4f-4f2a-a143-16d3ca62f44a@nutanix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jan 04, 2024 at 01:13:48PM +0530, Het Gala wrote:
> Ping. In-case this patch has been missed out. Waiting for other maintainers to respond. Thanks!
> 
> On 11/12/23 6:43 pm, Het Gala wrote:
> > Ping? Waiting for other maintainers to respond on this patch
> > On 05/12/23 6:28 pm, Fabiano Rosas wrote:
> > > Het Gala<het.gala@nutanix.com>  writes:
> > > 
> > > > The inital conditional statements in qmp migration functions is harder
> > > > to understand than necessary. It is better to get all errors out of
> > > > the way in the beginning itself to have better readability and error
> > > > handling.
> > > > 
> > > > Signed-off-by: Het Gala<het.gala@nutanix.com>
> > > > Suggested-by: Markus Armbruster<armbru@redhat.com>
> > > Reviewed-by: Fabiano Rosas<farosas@suse.de>
> > > 
> > Regards,
> > Het Gala

queued in staging.  will be in the next pull.

https://gitlab.com/peterx/qemu/-/tree/migration-staging

Thanks,

-- 
Peter Xu


