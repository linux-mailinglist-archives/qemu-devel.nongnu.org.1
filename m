Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7EE7E385F
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:01:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0It3-000478-MT; Tue, 07 Nov 2023 05:00:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0It0-00046W-Gu
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:00:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0Isy-00008t-EU
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+bSNkL9ziPJfmRRYcePTz2fkGsYnCVpi7GFulxLjr/A=;
 b=Qf/E3Czenq6DGEKZffpHUUAKkgTutaV/6MqA+zPXfXZitvKPlmEZNT/1eq42wqAuqoxaHN
 8IPsVwxah6TtN2oJ72Duqj3+YtzmqfY+k7Ev4yCgLH0yiP6Rmq+Kt9X/oO8xs1Pb+zbjLd
 dRhAZqrsbgMlfyhmA1WFsrY1sJnMYeo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-bYxB1TZhOsqQarvVBsKKMA-1; Tue, 07 Nov 2023 05:00:37 -0500
X-MC-Unique: bYxB1TZhOsqQarvVBsKKMA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32de9f93148so2909840f8f.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:00:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351236; x=1699956036;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+bSNkL9ziPJfmRRYcePTz2fkGsYnCVpi7GFulxLjr/A=;
 b=Jb0DPv/E5crtuIPkv32hPd3G7p/of7CtPHCaTBvfA0mNWs5la37Opqx+tsuOu+57ed
 sogjSceWQ5Y1qjV9zW+x6BadBax3zTTdvIj7+PmVtndIMXICGYR/LvXh6+eBFyuzLqBc
 kVms2Qcm+9R+Of10RPFoCkcnfKX3fJcIeqjxYXaVXWrEgPEIAQaQkXgGlEgP10UoWp1L
 AlJ0bYgX/m/DIvI/GQdhTegL54IOo8IZaLT/ucxXjRJikETGyXC+/jLCrrhzdOEPaSgD
 Hq8jAC9DO6ObH2NC9n8SUZ/+BfHCCvaLQkxO/ybhDAcMmxzniBGdKxMJBRj2dUEsYNFG
 FZ7w==
X-Gm-Message-State: AOJu0YzFj2YuglDg3osRtyvvrk4ALNoBN1wBdVC4WvN0h6uXW08dNzHa
 iMaDMRhP7mz+hU9WgItNyaAJ1VcjaH4l/St4OcoTquPQqc8Pcu2P7txzfEk+A46Z+WLJYb6v+tk
 ig+ChkPtmf+AX+A04GZaAgBA=
X-Received: by 2002:a5d:670c:0:b0:32d:8431:341e with SMTP id
 o12-20020a5d670c000000b0032d8431341emr20535328wru.62.1699351236147; 
 Tue, 07 Nov 2023 02:00:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7m6vjgecRz37j/pcpHpROSOzRa1niGyVt/g1M5dsQwkLPmh+TwPm17NV4sS7boEHeluqFZw==
X-Received: by 2002:a5d:670c:0:b0:32d:8431:341e with SMTP id
 o12-20020a5d670c000000b0032d8431341emr20535304wru.62.1699351235803; 
 Tue, 07 Nov 2023 02:00:35 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 j15-20020adff00f000000b0032dc74c093dsm1859834wro.103.2023.11.07.02.00.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:00:34 -0800 (PST)
Date: Tue, 7 Nov 2023 05:00:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH RFC 0/2] dynamic timeout for tests
Message-ID: <20231107045337-mutt-send-email-mst@kernel.org>
References: <cover.1699349799.git.mst@redhat.com>
 <677fe308-5dc2-43d8-8ca4-114c528d0823@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <677fe308-5dc2-43d8-8ca4-114c528d0823@linaro.org>
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

On Tue, Nov 07, 2023 at 10:57:23AM +0100, Philippe Mathieu-Daudé wrote:
> Hi Michael,
> 
> On 7/11/23 10:49, Michael S. Tsirkin wrote:
> > so we keep making timeouts longer for CI but one has to stop
> > somewhere. netdev socket test recently failed for me again
> > even though it's at 2 minutes already.
> > here's an experiment for netdev-socket.
> > if this works well for a while we can generalize to other
> > tests.
> > 
> > Michael S. Tsirkin (2):
> >    osdep: add getloadavg
> >    netdev: set timeout depending on loadavg
> 
> The 2 problems I see with this approach are:
> 
> - Machine load can vary *after* the test is started,

Then it won't help. But better than increasing timeout
all the time, no?

> - Test environment isn't really reproducible.

But then load intrinsically is.

> Are those netdev tests only failing due to high load?

yep

> Maybe we need to disable them on CI and run them manually...
> 
> Regards,
> 
> Phil.

Most of our tests are like this.

-- 
MST


