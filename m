Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF7A7DD08C
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 16:32:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxqiG-0004ti-VA; Tue, 31 Oct 2023 11:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxqiE-0004tC-4s
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:31:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxqiB-0002Nk-Ft
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698766280;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o+A2Fu7tYpOlc4hCvrRVYRCiPKMJeWGmpAOmrKOo4dw=;
 b=hUS9cp4WMBXPBsIYKno0BYv4npr46p9RmMIRpzm71lhD+zGEi8X9gnrwYm6ELAH0UewiW5
 B+pDNgJ6VJQb4WXEnYfOQFaRQaALOozsxxdMae3lhk31ZyauKBFRVq6ZJyHAnc9Mri808x
 AXtwn3+gWPbNa3iZJExgdDy1nevr8ZM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-9-hg_RCdMfiBl4drE4c7Cw-1; Tue, 31 Oct 2023 11:31:18 -0400
X-MC-Unique: 9-hg_RCdMfiBl4drE4c7Cw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4083717431eso41278705e9.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 08:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698766277; x=1699371077;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o+A2Fu7tYpOlc4hCvrRVYRCiPKMJeWGmpAOmrKOo4dw=;
 b=IiYiXemNjK8qY5C2Dcrygp+e+Yn6Z0K+cVO8JB4mnXyG6g+jSanDikA+syr7CQgYtz
 Kxhse27RmJkoJLLoTphoKwfYr4o81Zre4M16yi42oWrAvXvEqkLu0MiLmHrm2beVMPv/
 i8K45nGBrFuXpeuwU36U1iuseK8iL8m+5ZzdBULvQNnXKPH2QMLwoi/GsT2VvkGYB2fw
 sxfAhrk196AotP2PNhVv/v+rCCgcPVoeIaoPk5N22onDYaayHVVFAwMA4VEBeH8x6bnt
 EiGricQgCLiagFidy7Qi/WDbvZ80KEYi2rYEMDd9cINqaUuMAS1lyvzQaPzOR0SPkFFf
 TxBA==
X-Gm-Message-State: AOJu0Yyi7ThLq4xnXnFpDd3CH+wO0HcX+hOuqo00jvEbx5uwhAL7tYWV
 edeaiJnTevad90FpN2/QHLCOl5yyi5ULl8lYHS+zVxr+ThcJ/zWYnnEFY6zqS7KIzR2BydXh1xR
 Gmc1EaHph6jwIsVI=
X-Received: by 2002:a05:600c:1d18:b0:408:4475:8cc1 with SMTP id
 l24-20020a05600c1d1800b0040844758cc1mr12225544wms.35.1698766277486; 
 Tue, 31 Oct 2023 08:31:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqefCNl9QE7dkdF60litKsM6SqkSUvFsSYlaNPkasrM7wcx/u4K7IUCgGKt2k12K9RBLUv2A==
X-Received: by 2002:a05:600c:1d18:b0:408:4475:8cc1 with SMTP id
 l24-20020a05600c1d1800b0040844758cc1mr12225509wms.35.1698766277088; 
 Tue, 31 Oct 2023 08:31:17 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 bg10-20020a05600c3c8a00b0040776008abdsm2116214wmb.40.2023.10.31.08.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 08:31:16 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  dgilbert@redhat.com,
 pbonzini@redhat.com,  berrange@redhat.com,  armbru@redhat.com,
 eblake@redhat.com,  manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com,  Het Gala <het.gala@nutanix.com>,  Peter
 Xu <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Li Zhijian
 <lizhijian@fujitsu.com>
Subject: Re: [PATCH v15 06/14] migration: convert rdma backend to accept
 MigrateAddress
In-Reply-To: <20231023182053.8711-7-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 23 Oct 2023 15:20:45 -0300")
References: <20231023182053.8711-1-farosas@suse.de>
 <20231023182053.8711-7-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 16:31:16 +0100
Message-ID: <87jzr26c6z.fsf@secure.mitica>
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
> RDMA based transport backend for 'migrate'/'migrate-incoming' QAPIs
> accept new wire protocol of MigrateAddress struct.
>
> It is achived by parsing 'uri' string and storing migration parameters
> required for RDMA connection into well defined InetSocketAddress struct.
>
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>


