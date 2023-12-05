Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6C98060DE
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 22:36:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAd50-0006wi-3f; Tue, 05 Dec 2023 16:35:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rAd4o-0006vT-Pj
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 16:35:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rAd4l-0008GM-JR
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 16:35:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701812130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T9iLhrc1QGE7oteoiEbNUVJU+sEbiGPgglplqLEGoc8=;
 b=dtZQnXvnwA3MsLigeT90uQtPAsUnqrL3t6QhlZx5AVQQIQX6hznzHq46bY3TswqLdPAwW0
 LKKvaDmuRR2E+RsHZ7TA1dWFRr3K0cdtFUL5Xkw2VGSY96cNaLOVO24xjJFA63QlALnLmW
 L15c0n4mYRClf2J08zvO/2dX0wT5rmA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-ID1eQOKlNvet3GDNaT_Kxw-1; Tue, 05 Dec 2023 16:35:29 -0500
X-MC-Unique: ID1eQOKlNvet3GDNaT_Kxw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-77d8df7c8e2so145178885a.1
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 13:35:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701812129; x=1702416929;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T9iLhrc1QGE7oteoiEbNUVJU+sEbiGPgglplqLEGoc8=;
 b=Idci+lDJ4KDcvMRQODnGp+xZgEfi++e2gZn+kqj08rxXLZ7TdEdgmxmnR0m5qgUjy7
 qhjbPo6xfG8nI45ZUjSZbAM2WNzhfS8t4HoNuE254w9k3dUE9kstkbHCXnWIJ0oRTQ5D
 Lt3zCkdlPAnsXaaYUQQF2IWO6VYK3eXp29NkNHDsaW0g0NuKAUQw8Q1By8GKB8MYYclN
 HyZExRtn0dqTpL4uJazbgJsBTmLr0fJHZvDHfdwxcthaJ2ElqTnF6CPltgAWhLOs1mIT
 /joKPAG5tpbOogvhy37wG9oSPb+nn6PPeTejMG73+m+xMr3Fap4K5NW+WG14CUfuBCi8
 pxkA==
X-Gm-Message-State: AOJu0YzqQiVJnjb09a4zdaGUKXM1u+QDpADJ6GSKphAEntY0YEYr8qBc
 CtQQiKC9eg7I6XPO4vgaFMfGRxTmP9YQpzs81vmCwjJmZwoshUX+oD0eK7L9ZK4mhxKTwGvQM7U
 vbUt1wLebb92Doyo=
X-Received: by 2002:ad4:52ec:0:b0:67a:2963:519b with SMTP id
 p12-20020ad452ec000000b0067a2963519bmr17315741qvu.6.1701812129074; 
 Tue, 05 Dec 2023 13:35:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdPLlmdlhLSMQGBCHDqAFKAalc++KI0sqQQUwPTSe73IVdDZoDaQ8lFvkS4S1/s8wmjXPcFg==
X-Received: by 2002:ad4:52ec:0:b0:67a:2963:519b with SMTP id
 p12-20020ad452ec000000b0067a2963519bmr17315732qvu.6.1701812128781; 
 Tue, 05 Dec 2023 13:35:28 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 x19-20020a0cda13000000b0067a3abec392sm3590618qvj.66.2023.12.05.13.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 13:35:28 -0800 (PST)
Date: Tue, 5 Dec 2023 16:35:27 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V6 08/14] migration: preserve suspended for bg_migration
Message-ID: <ZW-Xn3G6DUnETQlP@x1n>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-9-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1701380247-340457-9-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, Nov 30, 2023 at 01:37:21PM -0800, Steve Sistare wrote:
> Do not wake a suspended guest during bg_migration, and restore the prior
> state at finish rather than unconditionally running.  Allow the additional
> state transitions that occur.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


