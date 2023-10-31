Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0856B7DCFDB
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 16:04:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxqH1-0001kv-Pd; Tue, 31 Oct 2023 11:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxqGy-0001gB-MR
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:03:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxqGp-0005aw-3j
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698764575;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=dAGZhWkNIquLqIiqu5L5Lc1sQTPRePa2nvQW7684jxc=;
 b=f5qt5nnKlgObfvVCVp30abbmhTX8EZB+YORoWRoAHEDjAk4tUP079xVGuMvKwfEZgpuTqq
 U3nb7pGGTwUWVOOpaghTcUPQ87kVi3T06WKExN0dGYrtCIw4/ExRa6z6eSNoC1o4hRqYPR
 tiXwaZSbqoeDujnZE2FE0w/AMrYlNbE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-QzaJTk7uNSihT9GE6oI6mg-1; Tue, 31 Oct 2023 11:02:39 -0400
X-MC-Unique: QzaJTk7uNSihT9GE6oI6mg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-507a04c6fdcso5986924e87.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 08:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698764557; x=1699369357;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dAGZhWkNIquLqIiqu5L5Lc1sQTPRePa2nvQW7684jxc=;
 b=nv9l88bOJx8TLoahureYshO4CO+019qvC73rI8jy/ekHksy0octVh2OWb6s/DAWptE
 AbWJk6f5cM3ZTi2mtbV2R/A9tlaO99CC/EVdGGncDu9UCJjHhz4n+8rD2x14Lf5UsSr2
 9Y/vaZ6VVJKuNjKvGpci16+yKOcZqJ6VRNITsI6nPY/JHbL5zfmL3+pu+l0o+wtDOwv1
 6eeDrU5XAzANlgFrt2nFy6m2ZT5qudME8Xww+lauQN6wGBmq7gg80qL4FZUSWSmHjHgM
 LKh1hD7ovO+yNT0XwCGqtm+/QFQv1rWDHkt2R8riOcZFNH76+96C9nEBCamNSy1/SFi5
 9ZtQ==
X-Gm-Message-State: AOJu0Yz1DuVA0qWry98NcSmvuiF+atdAA2xq/E3dKI+bgIoSmggV6sWH
 wxHhdvGpyLd24S9y8FdSWxRKqoJhhtvtYahlKXsttFJSk7EJUHztXJnk4K4SGndaoQuloJ6vpbW
 T/rQHupkyUfNYsRY=
X-Received: by 2002:a05:6512:3ad:b0:508:15fb:d419 with SMTP id
 v13-20020a05651203ad00b0050815fbd419mr9186357lfp.57.1698764557588; 
 Tue, 31 Oct 2023 08:02:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2b/Rom1TTbe7yopcTgBaxqI9SqQWdbiYJg+CJbVPuWL8YRTA2WFr16pxTz5VPvgklKNGKXg==
X-Received: by 2002:a05:6512:3ad:b0:508:15fb:d419 with SMTP id
 v13-20020a05651203ad00b0050815fbd419mr9186322lfp.57.1698764557231; 
 Tue, 31 Oct 2023 08:02:37 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 f19-20020a05600c155300b004054dcbf92asm1999737wmg.20.2023.10.31.08.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 08:02:36 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  dgilbert@redhat.com,
 pbonzini@redhat.com,  berrange@redhat.com,  armbru@redhat.com,
 eblake@redhat.com,  manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com,  Het Gala <het.gala@nutanix.com>,  Peter
 Xu <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v15 03/14] migration: convert migration 'uri' into
 'MigrateAddress'
In-Reply-To: <20231023182053.8711-4-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 23 Oct 2023 15:20:42 -0300")
References: <20231023182053.8711-1-farosas@suse.de>
 <20231023182053.8711-4-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 16:02:36 +0100
Message-ID: <871qda7s37.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> From: Het Gala <het.gala@nutanix.com>
>
> This patch parses 'migrate' and 'migrate-incoming' QAPI's 'uri'
> string containing migration connection related information
> and stores them inside well defined 'MigrateAddress' struct.
>
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>


