Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
Delivered-To: lists+qemu-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA6dL368b2kOMQAAu9opvQ
	(envelope-from <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>)
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jan 2026 18:33:50 +0100
X-Original-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 727DE48A28
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jan 2026 18:33:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viFbR-00089k-GL; Tue, 20 Jan 2026 12:33:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viFbE-00085b-1d
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 12:33:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viFbA-0004G2-NL
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 12:33:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768930380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kAdCBY/46JJWp8qAOLL5mvW/XijKZTD7McbyxFPfK7c=;
 b=FQ3Bdu77FP9woIYEkuvvXJuWU6zgsNWsl7/D6QhapxdUyprh2/Bi9sxx+Ab0Cv3RT0O18v
 hy+aKieUbBncqpc5RvouJPQ1NnbiLW8yAeG4zMeyvSuX6Xm0uH6eIYtLRnihcBFaxmX5CE
 W+4+GjcptMYSqFcl+GyUvaZ7Dcrxo58=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-HJzTJmW4M_-R4b2qjtGFVg-1; Tue, 20 Jan 2026 12:32:58 -0500
X-MC-Unique: HJzTJmW4M_-R4b2qjtGFVg-1
X-Mimecast-MFC-AGG-ID: HJzTJmW4M_-R4b2qjtGFVg_1768930377
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2b0531e07e3so5171935eec.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 09:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768930377; x=1769535177; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kAdCBY/46JJWp8qAOLL5mvW/XijKZTD7McbyxFPfK7c=;
 b=bdy2YxyKbiXMmkITjlDPQpMwO+3zg4qgMHgZ2dBh9FuiqDlNFuxyCblY4f6AtQi/Kv
 mX5y7I4N2XIFF66nEYiSM9V/JfaHILwsG/QOT/90xAlqDlbdr7ncRxMHmVlAAO0PZkFF
 SDTrgQzsZRFaZEyqqOQolcOjFEgcfN9N3HCF2bsHb8YXAtvxW2EuxPLpUfM5nT62UgG+
 ZpOs5JxX2D50zibnuM01tGB01M77Dewtpb05kgjKKM6/yGTHkVJJEzgAgN4DpEnOLYkI
 wCzvudzxfMUmJoavs0fGvwxbvbdspQDJZdQJW5/1BIGBziTgd2vMeuf0NY+XYmJKpTil
 UmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768930377; x=1769535177;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kAdCBY/46JJWp8qAOLL5mvW/XijKZTD7McbyxFPfK7c=;
 b=otOgfEyLy1yJzAfENRxWMNOmmZpFa3QGkTaiTbygGweSa+xQj64gaaaR2Z5sTJ7Azm
 fhaEJe6PN3UxB8hK3hGB4XBu+Dg70DZXKb9T9r9pprIgjnJX7/8wdZFdK0VzTgyPeGjq
 //PmL7f//gsqMSgOQ8JDLZpE7qKrE2SnBKehcIeGlD3vWXAyuqKID7UdVYbtUgMlMrhB
 SSxfpOvYeuSZjXgngC6kL/g7vmqXK8Uk0rwWM5pnmv8BQ3piEfNc5eGao+wgzyCitIUW
 QSlhppkRMR9POQOqw2v53ogDV3/AqzdN8DIjAI/Puhwc8U19SvcEBK5QaNrjvJZQ7I0k
 zpyQ==
X-Gm-Message-State: AOJu0Yx2H5NggbjKW6WvWqXsP98U2FMVj/DwlvCTo3IwxowBWmuyXMCs
 GrjhIIsLq53/3/PrAfwRGmIihZgT1AXMyWYloAJr5yubpZkjKV+hs5dOuVR2GZEY/1Mg3PkBQRw
 yn28464gLFL5rYJLoMSxozDyE6TosbD67DGWyTseI/sKYrOuZ9xODuGqy
X-Gm-Gg: AZuq6aJR33ZoRA09PB0qqYk/pKyxjE4WfKkYIHpleWpvxDqj25F3UFyInYgOpjPRfJ3
 R3U9NQgX6cGA3MdSSF7wP9TTUxtkrIz1yUNefNiQhNqRDwPwg8bXQcQjKzE1W/2S9fPWwzI4DMY
 XMJ6O7NQGOf7EMQoRGbQmULYS3xAvkFNo6OUaCLZkseS6hyfn6/XalazyBt6oK1NZRaPXYKvbTD
 34uxbIIBbIzEJHdttjVmkpi42R7s5hCQPGF0lDTI0RCwSZzTAFZKWV4wGJFqrkNOaHAMRhA1JWW
 oQvJRiCat05cEliDn2mVBFUKGkr+GLFevYYO4s+Pdulz3kFVF+H8hOWMAhieSHWUZz2bwza8bsP
 hvvc=
X-Received: by 2002:a05:693c:2c96:b0:2b6:c03d:9ff0 with SMTP id
 5a478bee46e88-2b6fd78dfc2mr1731565eec.22.1768930376405; 
 Tue, 20 Jan 2026 09:32:56 -0800 (PST)
X-Received: by 2002:a05:693c:2c96:b0:2b6:c03d:9ff0 with SMTP id
 5a478bee46e88-2b6fd78dfc2mr1731531eec.22.1768930375580; 
 Tue, 20 Jan 2026 09:32:55 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b70b3c8ea3sm872685eec.22.2026.01.20.09.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 09:32:55 -0800 (PST)
Date: Tue, 20 Jan 2026 12:32:48 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 2/8] MAINTAINERS: Remove Hailiang Zhang from COLO
 migration framework
Message-ID: <aW-8QNQJ3PvBD35r@x1.local>
References: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
 <20260117-colo_unit_test_multifd-v2-2-ab521777fa51@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260117-colo_unit_test_multifd-v2-2-ab521777fa51@web.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
X-Spamd-Result: default: False [-1.21 / 15.00];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.51.188.0/24:c];
	MAILLIST(-0.20)[mailman];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lukasstraub2@web.de,m:qemu-devel@nongnu.org,m:farosas@suse.de,m:lvivier@redhat.com,m:pbonzini@redhat.com,m:zhangckid@gmail.com,m:zhanghailiang@xfusion.com,m:armbru@redhat.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[lists,qemu-devel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[nongnu.org,suse.de,redhat.com,gmail.com,xfusion.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[web.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[peterx@redhat.com,qemu-devel-bounces@nongnu.org];
	FORWARDED(0.00)[qemu-devel@nongnu.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PREVIOUSLY_DELIVERED(0.00)[qemu-devel@nongnu.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterx@redhat.com,qemu-devel-bounces@nongnu.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[qemu-devel];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:22989, ipnet:209.51.188.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.gnu.org:rdns,lists.gnu.org:helo,x1.local:mid]
X-Rspamd-Queue-Id: 727DE48A28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Jan 17, 2026 at 03:09:09PM +0100, Lukas Straub wrote:
> His last email to the mailing list is from December 2021:
> https://lore.kernel.org/qemu-devel/20211214075424.6920-1-zhanghailiang@xfusion.com/
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


