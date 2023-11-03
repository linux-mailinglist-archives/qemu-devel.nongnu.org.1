Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF7A7E01A2
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 11:44:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyreD-00040m-6h; Fri, 03 Nov 2023 06:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyreA-00040Y-Qq
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 06:43:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyre7-0001vM-TN
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 06:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699008201;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=cFfMoYK2y+vhqNcmhlIo+Hzsw922AAwrVDDImGGjBmI=;
 b=YKlp/8UhuOYf55oKzJ0ntHxUE/hhbEiQuLlq3cvliKVoOdRrHsR9jBdL2zdZYiDJ5FQuyc
 GC5WOaojdpXQh1gPVsLIVYGITgwmWFCjN3CgdRZnIv831HVRVZvn6R6PpF4T2htltAp5NT
 8q0CAY46affmOxt/MC3xH2LAVG7puLM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-t-8Q9w0GMEyS2wz2LIDBYQ-1; Fri, 03 Nov 2023 06:43:19 -0400
X-MC-Unique: t-8Q9w0GMEyS2wz2LIDBYQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5082705f6dfso1741929e87.2
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 03:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699008198; x=1699612998;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cFfMoYK2y+vhqNcmhlIo+Hzsw922AAwrVDDImGGjBmI=;
 b=fjaMz/TC+JKM7hQ4hsPelIv6MrPci3UZgD7p2mpWn9myRqlykEmgbdbl3EordIVSFC
 NL39UE2vn8it3xWLRB56KiPGtUqrY+WYrmnO+cusXBXu3OxIVj7zcH0v9+TcMCQP9ENd
 JlNaYM7HEj96pRV0VMPxVFVg/bIX0+Us6mCb1m5xdUPucDrRsdyyOyRw8RiWn0o1lgMN
 Tpc+WNSqJs9J87q2ktZPFReZpny1lwwyB724KU7FC2qVPZ+Hk4RnlZ4+AOOFvnz0X0/R
 ixg0N5XRhDsXZ9u6BR6HU1tQ0uJM5EYNWWAaPhxOXjW0KcJpBdZt1KPVVskeFm6kqQpG
 105w==
X-Gm-Message-State: AOJu0Yycx1AlRb48ybsID+n89q8ORNHHBP2IWyAYkljacpfYZe52UbSM
 /SImkTFgNRWVwU+kcQgM87KjwnQeyFJdoD2ruijlu8BZvuJSaCYrG8z+YW6JpxiZqiQ0cHFrKLi
 Arponctwer79zMdk=
X-Received: by 2002:a05:6512:21c2:b0:507:a9e1:5a3b with SMTP id
 d2-20020a05651221c200b00507a9e15a3bmr14600718lft.0.1699008198300; 
 Fri, 03 Nov 2023 03:43:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc5KpVz10aCBIF17hnUPUvqnzjCVKuRCMzbax9wQONoI83YbJu6jksgHdtkt8HgFrpOjxYng==
X-Received: by 2002:a05:6512:21c2:b0:507:a9e1:5a3b with SMTP id
 d2-20020a05651221c200b00507a9e15a3bmr14600700lft.0.1699008197899; 
 Fri, 03 Nov 2023 03:43:17 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 l22-20020adfa396000000b0032f7d1e2c7csm1536375wrb.95.2023.11.03.03.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 03:43:17 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  dgilbert@redhat.com,
 pbonzini@redhat.com,  berrange@redhat.com,  armbru@redhat.com,
 eblake@redhat.com,  manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com,  Het Gala <het.gala@nutanix.com>,  Peter
 Xu <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v15 12/14] migration: Implement MigrateChannelList to
 qmp migration flow.
In-Reply-To: <20231023182053.8711-13-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 23 Oct 2023 15:20:51 -0300")
References: <20231023182053.8711-1-farosas@suse.de>
 <20231023182053.8711-13-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Fri, 03 Nov 2023 11:43:16 +0100
Message-ID: <87y1ff15iz.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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
> Integrate MigrateChannelList with all transport backends
> (socket, exec and rdma) for both src and dest migration
> endpoints for qmp migration.
>
> For current series, limit the size of MigrateChannelList
> to single element (single interface) as runtime check.
>
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>


