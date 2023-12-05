Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AADCA8060E5
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 22:36:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAd5c-00084S-Nj; Tue, 05 Dec 2023 16:36:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rAd5b-00083i-Dx
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 16:36:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rAd5a-0008KT-4R
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 16:36:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701812181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bjgsgu1TaB8BjFdK8CwcRlGCoNdOgf5fzaVBCggJlJo=;
 b=N+rrd2HXHKqGKd7pOOfysWlNPW/S06+Ws6faGhHCMvOl/ipavcW48j4bMcAwevglo/v8+p
 SF9QSLwqCUGGzalp26Lo9I4BzLgsEpEZJhT3Azjf02BPHibVBtRNwGOE4Jd5YOgOkol39H
 Zayxe75PO77YjRTktQmYH2cURD2oz0Y=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-XnDk2pLOOt2Zj8Mdn0B8Kw-1; Tue, 05 Dec 2023 16:36:19 -0500
X-MC-Unique: XnDk2pLOOt2Zj8Mdn0B8Kw-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-423c28eababso17065671cf.1
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 13:36:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701812179; x=1702416979;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bjgsgu1TaB8BjFdK8CwcRlGCoNdOgf5fzaVBCggJlJo=;
 b=b4Cva4gG5ciTGft/lPIDO8kByMZYfJI3yLIlAJGeTZpKRBedWzcQluf/IioZJ4X0pD
 gCpjVF8WSZpmc2pT4ituiZC3OQUgpEVUD6bg2I9HFs3zbxN362TB8NHpyWKGMU29GWtO
 aV/COC/7I5m+IrcSCoJ1xGtDmA6cqEYDiAyg0RTGVlW24H2xecpoXIqytPrQ0YITXWpW
 cV9GaF6dhg8m0EkhdQcSrWtXZ0X6iwIczUZs90n9YcG+K0blV7JvSb8Dgu08EooM8kbv
 VQBC4XWYDUw+pU9oTLyn0eUiMYVlWWuv//xm3Ml9w2hDUVZBTzySdYRQLYNwJffeG+wi
 Hxkw==
X-Gm-Message-State: AOJu0YwYdlwCBn/Esa4c/xbvVnSXfO7W3rB4ByDR1eNRyTR01IPWsLbL
 FF5pH8X5VgRJs+rN0M3tMRIZq/5d0BlH+8p6ANQo+LB3P1dWvVNfNWX62u5CNBZHlPfUrYoQJfZ
 NEvCMNUp/9Z8AMq4=
X-Received: by 2002:a05:622a:4c1a:b0:421:9fe5:6dc1 with SMTP id
 ey26-20020a05622a4c1a00b004219fe56dc1mr45046537qtb.3.1701812179505; 
 Tue, 05 Dec 2023 13:36:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMKkzIIb2vSzTjsAxdj+kJHMXMBBsdA1qM8hBLk0U3tLzxxF3gBB66cvCFbiccJf7VBR8i6w==
X-Received: by 2002:a05:622a:4c1a:b0:421:9fe5:6dc1 with SMTP id
 ey26-20020a05622a4c1a00b004219fe56dc1mr45046508qtb.3.1701812178891; 
 Tue, 05 Dec 2023 13:36:18 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 jd24-20020a05622a719800b00425438e7c5esm3478916qtb.62.2023.12.05.13.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 13:36:18 -0800 (PST)
Date: Tue, 5 Dec 2023 16:36:17 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V6 04/14] cpus: vm_resume
Message-ID: <ZW-X0cvZ2ypZAtC0@x1n>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-5-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1701380247-340457-5-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Thu, Nov 30, 2023 at 01:37:17PM -0800, Steve Sistare wrote:
> Define the vm_resume helper, for use in subsequent patches.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


