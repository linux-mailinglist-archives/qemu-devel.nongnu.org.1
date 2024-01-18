Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 137EE8312E4
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 07:59:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQMMD-0000rK-2N; Thu, 18 Jan 2024 01:58:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQMMB-0000qv-Ew
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 01:58:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQMM9-0000He-WA
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 01:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705561109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lk3TKFXT/grUyqMjs+CSzJrcAbaFYi0WBRE6fxtrzzw=;
 b=URapGZoa1oJW3PIsuQ17PwN7DeGG2Loh5QcBb6mv6mek2l3BIufQFCovMRPogeH3O6Nl6H
 9BMOw4lcyju2Acxg6g3waclbU9ZzzNl+oH5H+pzYrkgN7pm2TwT+/KDH6y+Fch5HeqTlbh
 vu5i2iUlgkyLWZJXoIjbwWr0Tab09sA=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-mEvVifTdMSaHlrnWPj8eag-1; Thu, 18 Jan 2024 01:58:22 -0500
X-MC-Unique: mEvVifTdMSaHlrnWPj8eag-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5ce9b15f4ccso1463432a12.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 22:58:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705561101; x=1706165901;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lk3TKFXT/grUyqMjs+CSzJrcAbaFYi0WBRE6fxtrzzw=;
 b=s2xfyOy7sXUGkNrCZZr4EKAParslUhR0nGUQ8Tt1Ua9BtyawUjSgyDHXIGxnw2gau6
 TmnJnG7VIoH4COnSXAVh9YAS9z3XKGV3Ym+DCDlKjhJI8q8C6a5lLB17eYLWVU8m37XC
 8VaF4QCGdUvXbGtuaGQMr2oW1WVZbzueugQqffCxaizmDL4bmdGX2ybtT7yVpy8arleA
 rOetiY6DsxLl3QD8tZxD8wPMvDRbuDUtviXczs6xjjUnOKK9rnLJl44CSBfl+EC8Q52v
 xu87AATldcUawy7MF7mE1Jbr9XT881U36eBm2Waf/0eJ0r3ezVj5IvwJC3dRi/usTND0
 mLQQ==
X-Gm-Message-State: AOJu0YyV+Th1Vbq7vmYxl3oveiGvksk9we3OYiNEueg+1moEBTmZ87A1
 rcZjXc5bEgZAUIdVuWPJuD0mr3JEiqaIpOn9m91dvjOFFOm1nxHnUk//iY4dIzwc8t9sYDg73jC
 ZYG8rVD9FOR9ClLJBj9aTeYEgKAaAGfHV3EX6Y3z5EP4mnRCSXmFvUYAu6tO6
X-Received: by 2002:a05:6a21:588:b0:19a:bffa:f28b with SMTP id
 lw8-20020a056a21058800b0019abffaf28bmr724351pzb.2.1705561101044; 
 Wed, 17 Jan 2024 22:58:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFO234nGFgrxM/ny9SD6Pn834i1CBW0lE4aVRkULmi8//lUqWLyYTbKXah5coOZ0mWdTeji0Q==
X-Received: by 2002:a05:6a21:588:b0:19a:bffa:f28b with SMTP id
 lw8-20020a056a21058800b0019abffaf28bmr724343pzb.2.1705561100753; 
 Wed, 17 Jan 2024 22:58:20 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 ks6-20020a170903084600b001d6fbaaeb56sm691448plb.145.2024.01.17.22.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 22:58:20 -0800 (PST)
Date: Thu, 18 Jan 2024 14:58:15 +0800
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, het.gala@nutanix.com
Subject: Re: [PATCH] migration: Plug memory leak on HMP migrate error path
Message-ID: <ZajMB-qhshiAsEXV@x1n>
References: <20240117140722.3979657-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240117140722.3979657-1-armbru@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jan 17, 2024 at 03:07:22PM +0100, Markus Armbruster wrote:
> hmp_migrate() leaks @caps when qmp_migrate() fails.  Plug the leak
> with g_autoptr().
> 
> Fixes: 967f2de5c9ec (migration: Implement MigrateChannelList to hmp migration flow.) v8.2.0-rc0
> Fixes: CID 1533124
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

queued, thanks!

-- 
Peter Xu


