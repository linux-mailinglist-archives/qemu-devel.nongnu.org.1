Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA42882D442
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 07:39:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPGco-00052w-4z; Mon, 15 Jan 2024 01:39:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPGcY-00052X-Hy
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:38:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPGcW-000795-KB
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:38:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705300731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DvphZJejZVvTx+TKfeLRExLD4cnHQTMrz8aUr89abQA=;
 b=E5JrJMkCMo01abJMr6tTj6ArqNfSwWf/JzC35EJnWl4AY204TlPLD+X93TgS+FxRvRL/BB
 TKyrJsoZGHi5zLp6679OJSu4095cw8cU5dPNz4sVJ2F+Wbfp8HpubkoQ4985T77UG1JMNj
 FyW/V3mSFCoIlQ9RVp557acY7QKVMXc=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-7IV8LC3TNw2HYQu2jb-1aA-1; Mon, 15 Jan 2024 01:38:49 -0500
X-MC-Unique: 7IV8LC3TNw2HYQu2jb-1aA-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6da4d130a82so2212661b3a.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 22:38:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705300728; x=1705905528;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DvphZJejZVvTx+TKfeLRExLD4cnHQTMrz8aUr89abQA=;
 b=Q2NYC0xdJCCPkRr416rHRDJ7iPU97tb2ySIbi56WDFT0JSteFUJ5yr8+iWBMsUA1DX
 G5aewWX2B9/KO3yiZgu53WkEEZm729xixNBRCjbsWSjjxlywSu9unLWjvp/oY6h0oD6I
 nvS3T13tWIX7aBpvPVTRhdml8MyejuwPPWZlbgpaS9ZP2mktXAarvGPnm2IULMsSbsT3
 165I8WOuKgfm/shkKsG6Igk4F/WUCdiKUbyttEb9g6pWyRlBPjvego/5tF8Vup+cQQeF
 I0B+L0YcC9i+Ku54Rcx2Dm2sEsjy39NhK8GICJWQ1Z1ZkcZAuJc7po5/lXMl0LRf6QY1
 ZPMA==
X-Gm-Message-State: AOJu0YwSbQX8FqD1LS7kn2GEZNhdLmRpeDG00vQKvorcZaNCS43RMlKJ
 JJDIEyzBfJ7tiY4H5tZf2l9O6rV7it+rXqsqeh9/V8zLFKnY2RsF0c2rS8v6InbSCWmIG+uchc3
 aWN5ed9R9BgwnpChTvj6sDwc=
X-Received: by 2002:a05:6a00:939d:b0:6da:83a2:1d9a with SMTP id
 ka29-20020a056a00939d00b006da83a21d9amr11608046pfb.1.1705300728300; 
 Sun, 14 Jan 2024 22:38:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHONRBbfH+CNHMqoT1I2J1BnSGTyScrVtKDOJUQ/C33agVNLMcB5lXhur6JtKGz+yCWP5Zm+g==
X-Received: by 2002:a05:6a00:939d:b0:6da:83a2:1d9a with SMTP id
 ka29-20020a056a00939d00b006da83a21d9amr11608033pfb.1.1705300728041; 
 Sun, 14 Jan 2024 22:38:48 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 fj15-20020a056a003a0f00b006ce9c8c4001sm6891386pfb.47.2024.01.14.22.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 22:38:47 -0800 (PST)
Date: Mon, 15 Jan 2024 14:38:36 +0800
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V2 01/11] notify: pass error to notifier with return
Message-ID: <ZaTS7CQ-rENrQX5J@x1n>
References: <1705071910-174321-1-git-send-email-steven.sistare@oracle.com>
 <1705071910-174321-2-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1705071910-174321-2-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
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

On Fri, Jan 12, 2024 at 07:05:00AM -0800, Steve Sistare wrote:
> Pass an error object as the third parameter to "notifier with return"
> notifiers, so clients no longer need to bundle an error object in the
> opaque data.  The new parameter is used in a later patch.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


