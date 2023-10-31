Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6817DD45B
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 18:11:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxsFX-0008Gk-CM; Tue, 31 Oct 2023 13:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxsFU-0008Fx-B5
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 13:09:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxsFS-0003De-LI
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 13:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698772187;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aeWEpi3+3tXddZQoESgQVyRash4gsR9McPoIUkJoz2Q=;
 b=YkeT7Z0wTQu6e0ShYXJumZD1JpqnAOlG3+9cf6p8i1Nzrr2PWJNhFXT+bHpfn2slqCDylN
 TnYD4NTfmY+J6rccE+tUEihdEHW+VccNqN7Na65Ty/6TKb/+IsvafU7bPJVIPJLtosCWgI
 7uToXYi3dmphRsWzi/lOmSsILymL95c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-ERHDrzZcNIKO5PpFuW6CEw-1; Tue, 31 Oct 2023 13:09:37 -0400
X-MC-Unique: ERHDrzZcNIKO5PpFuW6CEw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4084a9e637eso42188955e9.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 10:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698772176; x=1699376976;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aeWEpi3+3tXddZQoESgQVyRash4gsR9McPoIUkJoz2Q=;
 b=HW8Iyz0a7Z5pjDDk8oBU4GGwyA9tGoMkOItk1B8ElmZEXawuYmbO6bOsiJ4thHtrvQ
 54+znLyLaRruvvkztT/k/E4o05LP1ZDNTp9X157WGjJ1r53XVKiQ7MABSuV0VgqSrAtu
 RC4tyyikvxQlOa4D4y47IHO4aKhAi1b0k5zCtqt4T+RU51LsIMMUTOlsCu+j6vleQxY5
 OX0x6kHl9dqp66TyksvPkbmobhdHCXZMBUqii4/hyZh8FDPyqhuF4iNIBkmnhc9aUzFk
 UKT5dSlRMax0fVEuHSN7U/vwrjTPokFp9tis9JUsbD1w+ILOk+5dChFIXksm6HmV0tPS
 iLSw==
X-Gm-Message-State: AOJu0YwH9n2gEq9ifmGkMbwWT5p9VQCC7iQR3vad7NC435CzOF5UAgCj
 YDeMKuAwrFyz6UlvwSic70fDg6DMW5mI4lOQc1z8IMyI33Y53ggPkD4jHY6RML2UDqU+UDbh5UV
 rlu68+y/OP4Wzw/Q=
X-Received: by 2002:a05:600c:19cc:b0:406:8494:f684 with SMTP id
 u12-20020a05600c19cc00b004068494f684mr10077329wmq.23.1698772176118; 
 Tue, 31 Oct 2023 10:09:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe2nuCxl9hyKymt+Lr2sMwUbpauWrGgUyVuqg5pekQZamo8t5AXmPvPFZ2hpAKFWSCb6eP4w==
X-Received: by 2002:a05:600c:19cc:b0:406:8494:f684 with SMTP id
 u12-20020a05600c19cc00b004068494f684mr10077306wmq.23.1698772175767; 
 Tue, 31 Oct 2023 10:09:35 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 o16-20020a05600c511000b0040531f5c51asm2330318wms.5.2023.10.31.10.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 10:09:35 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  dgilbert@redhat.com,
 pbonzini@redhat.com,  berrange@redhat.com,  armbru@redhat.com,
 eblake@redhat.com,  manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com,  Het Gala <het.gala@nutanix.com>,  Peter
 Xu <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v15 09/14] migration: New migrate and migrate-incoming
 argument 'channels'
In-Reply-To: <20231023182053.8711-10-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 23 Oct 2023 15:20:48 -0300")
References: <20231023182053.8711-1-farosas@suse.de>
 <20231023182053.8711-10-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 18:09:34 +0100
Message-ID: <877cn267n5.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> From: Het Gala <het.gala@nutanix.com>
>
> MigrateChannelList allows to connect accross multiple interfaces.
> Add MigrateChannelList struct as argument to migration QAPIs.
>
> We plan to include multiple channels in future, to connnect
> multiple interfaces. Hence, we choose 'MigrateChannelList'
> as the new argument over 'MigrateChannel' to make migration
> QAPIs future proof.
>
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>


