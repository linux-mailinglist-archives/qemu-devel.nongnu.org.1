Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 691C4837DC7
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 02:29:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS5Zp-0004yU-AA; Mon, 22 Jan 2024 20:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rS5Zn-0004xZ-2b
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 20:27:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rS5Zl-0007j5-CW
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 20:27:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705973260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AVBgtZs/Ger0XtssyDMOo6hH+KUSlS7ADnEs4PwyKsE=;
 b=GLEq4QPG+oXLWyKagVTg8GHyKfib7xVldyqpOMuc7EBL6pwnUliszFf2hKvyMOf3LgRl0U
 74Furk5KIGYP0CJCkTHCn/OzTpaQg11KpIHOp4jefrMtqImBo5fscgTlIetQtap5HOl6YG
 csXmvoFxWgkEXkXheYzkcvrga0xxW6w=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-VrUSYnRgPt29bMAORBon_A-1; Mon, 22 Jan 2024 20:27:38 -0500
X-MC-Unique: VrUSYnRgPt29bMAORBon_A-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-28c0765415eso562163a91.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 17:27:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705973258; x=1706578058;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AVBgtZs/Ger0XtssyDMOo6hH+KUSlS7ADnEs4PwyKsE=;
 b=al0Q0cvSkWKJUToSCQ8HDVs3ocNpzPXseY465lPnyG2zgAz7bFT9fZdDzK7c6bZcMA
 ubPbjzGMif1yVPRsXxY8roozwCVRJkFHM3ZqPRyVucPH7AxOY74WQ+Q/YaGOZXIgRDXP
 HANlBWX9MCtJfVq2GoP2/Hh2CDhRLKvUSEZEKgh6pTlOO1wNqJIdpibg6GBzmFQT2DJ4
 jdzF2MgsIXfqRLGDKZYVf68eeEkN2BvaLD7oLXwk/5kCslQP99bHYtPo7D+opkIo8gqv
 mZqd8X2iYozWAjm9CNYTjh5MNXgNzWkGRpM7hMviwOGl/9rATMRrVaA7qJPtR+KYzA8e
 llYQ==
X-Gm-Message-State: AOJu0Ywb037bzPkp16AGoxCu2x5+yiTWpJHNvTYfyauSQKzF2FUXbZxR
 +95Ve3JNIb06sCazyt9m/LN3SF0GiyyhZ38/6OhDZGBU2HMRngqbDfmZB+EpgMjqpcHfNvgPY71
 AP+gT8385flwwj0sWzpRjpokjFqwKbT35MVsySMJ9jJHsV3PS/fAU
X-Received: by 2002:a17:902:ee05:b0:1d3:c5e4:b2f6 with SMTP id
 z5-20020a170902ee0500b001d3c5e4b2f6mr10108059plb.4.1705973255860; 
 Mon, 22 Jan 2024 17:27:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEo7qRKLe6IMN8bbhkzgt35lXQe6S37fN1hoDXkLJomzH4jcFAkNxBC5IFhfxeX5k6/9ZLttQ==
X-Received: by 2002:a17:902:ee05:b0:1d3:c5e4:b2f6 with SMTP id
 z5-20020a170902ee0500b001d3c5e4b2f6mr10108046plb.4.1705973255450; 
 Mon, 22 Jan 2024 17:27:35 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 w11-20020a170903310b00b001d73412b4fesm4112850plc.171.2024.01.22.17.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 17:27:35 -0800 (PST)
Date: Tue, 23 Jan 2024 09:27:28 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Lukas Straub <lukasstraub2@web.de>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v6 08/10] migration/yank: Use channel features
Message-ID: <Za8WAPR_dUZSKBHQ@x1n>
References: <20230911171320.24372-1-farosas@suse.de>
 <20230911171320.24372-9-farosas@suse.de> <ZQIV9RZFS0soEOJ4@x1n>
 <87il3lgmhi.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87il3lgmhi.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
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

On Mon, Jan 22, 2024 at 05:08:09PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Sep 11, 2023 at 02:13:18PM -0300, Fabiano Rosas wrote:
> >> Stop using outside knowledge about the io channels when registering
> >> yank functions. Query for features instead.
> >> 
> >> The yank method for all channels used with migration code currently is
> >> to call the qio_channel_shutdown() function, so query for
> >> QIO_CHANNEL_FEATURE_SHUTDOWN. We could add a separate feature in the
> >> future for indicating whether a channel supports yanking, but that
> >> seems overkill at the moment.
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> Hi Peter, this one has fell through the cracks, think we could merge it?

Yep, queued.

-- 
Peter Xu


