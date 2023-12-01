Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A16B800E9B
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 16:31:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r95Sl-0006d3-0u; Fri, 01 Dec 2023 10:29:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r95Sj-0006co-9V
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 10:29:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r95Sh-0001ha-I5
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 10:29:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701444590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PAIZqNQ4VpAOeWTueXbSaUx5bESlPIGgE8rPITPB9jI=;
 b=HJTOst4B2g+q40qhtKOVhRdwyv/Wv2ZVeSdiQCUPtcGeuaCtrRe9yD0kQyuQWJ/anE+rwl
 j8RqdyvcAPJYzQtRUkQxE2lnh9KTw2Q5U4NaYuAuOETnviqU092zO6GVATnZ2GxjFgaciA
 j7ukA+mP589yTUEaiANOw/Du1BVMs6Q=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-X7Bhi7EIMVCzyWQrz32uOw-1; Fri, 01 Dec 2023 10:29:49 -0500
X-MC-Unique: X7Bhi7EIMVCzyWQrz32uOw-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-7b395875bd0so50070939f.0
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 07:29:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701444588; x=1702049388;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PAIZqNQ4VpAOeWTueXbSaUx5bESlPIGgE8rPITPB9jI=;
 b=M8hiX9DMS30ntGw32htN8Bj65bACrUuAAICRfrtzxOrExuQ9qvraegEFZ4wis9F3Pd
 Q85fRqkE+jdHlRzyi7MfYOs2uNcfswz0/uYWk/GCP5miMsRMXtkYSZnPDSp548nSQ6Kc
 TeT74auq2Y0M7OYOHhOxReWre7lSpZH9B1BAlkdf48Uz+BvbATo8/KyWH8q6bVvYfI0A
 tbmFVhgYHbhLBmKP9XXEOWW8rQYr5s/fAqDrA4slycqgD1MiL5XIOFo6e5OcECbAEJZs
 ryC9wO/wWFsMsihKHN0GR7ljOwUB43jLDR8a1O4vc1qeei+GUGtWHFItTQdwfTVvU6KC
 +ilw==
X-Gm-Message-State: AOJu0YzhLJuiTug/ieEidBWCFnS5eeITkz4wX65o0G6CKZ0uWqrbCx1A
 ghV/EdMoGOhBMhX5/wXnaK+UEpRq9IJDLctD5Lhcy5oQriGKHEus7f7LHrmw2FDUM6Jlzc2VXnj
 PMEH/i3FR9Gap/jo=
X-Received: by 2002:a5e:9512:0:b0:7b0:75a7:6606 with SMTP id
 r18-20020a5e9512000000b007b075a76606mr25211405ioj.0.1701444588151; 
 Fri, 01 Dec 2023 07:29:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGz2sou/GxfaSK5tu8I0onM1KJ4RdHpFADFGEBq1yrcdoZtkLCtOnTfWVOF2gHsT/Hx4tq84A==
X-Received: by 2002:a5e:9512:0:b0:7b0:75a7:6606 with SMTP id
 r18-20020a5e9512000000b007b075a76606mr25211389ioj.0.1701444587872; 
 Fri, 01 Dec 2023 07:29:47 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 n20-20020a02a914000000b00466bb42cb4bsm882801jam.166.2023.12.01.07.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 07:29:47 -0800 (PST)
Date: Fri, 1 Dec 2023 10:29:45 -0500
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org,
 prerna.saxena@nutanix.com, quintela@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org, farosas@suse.de
Subject: Re: [PATCH v4] migration: Plug memory leak with migration URIs
Message-ID: <ZWn76Vtj7L_XBS6O@x1n>
References: <20231129204301.131228-1-het.gala@nutanix.com>
 <ZWjGdg-gic-C1PA_@x1n> <87il5j2io0.fsf@pond.sub.org>
 <ZWjfnIjec3udUZZ-@x1n> <87y1ee1m2m.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y1ee1m2m.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Dec 01, 2023 at 07:19:45AM +0100, Markus Armbruster wrote:
> I meant the first visible case, i.e. if (channels).  Sorry for being
> less than clear!
> 
> The problem is to free the result of migrate_uri_parse().
> 
> The patch's solution is to use @channel *only* for holding that result,
> so it can be g_autoptr: drop channel = channels->value from the if
> (channels) conditional.
> 
> Since this breaks addr = channel->addr, we move that assignment into the
> conditionals that reach it, which lets us unbreak it the if (channels)
> one.

My bad!  It also proved that my R-b was bold. :(  Thanks, Markus.
Since Juan's away, I'll prepare a pull.

-- 
Peter Xu


