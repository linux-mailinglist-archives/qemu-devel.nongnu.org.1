Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4037B7E76
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 13:49:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo0Mj-0004AZ-It; Wed, 04 Oct 2023 07:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo0MX-00047C-Qe
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 07:48:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo0MW-0003eI-HS
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 07:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696420100;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z0sfpH8M87D078Y7Fg88PAUsdf9e+wMYFkNHtd3uoYM=;
 b=NQ+CAlXtM4RhV2ah9Ly+WmuzAg+GTpf34EeFt8OMpMJp0T/JEPUWqJh4kel8lkx5mBD8qB
 1Dr+D7dyHjDueWw6aqOXJYzS1BG3t68qONX/FGIhTyY1ie85EszRcDz1RQRb59qlQALZ6V
 h+HySsvxEZz0vB3Ui/ctKXS5kbVffRo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-GFimpS9RMfKAjUGGSLgfMg-1; Wed, 04 Oct 2023 07:48:18 -0400
X-MC-Unique: GFimpS9RMfKAjUGGSLgfMg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4054743df06so14505365e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 04:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696420097; x=1697024897;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z0sfpH8M87D078Y7Fg88PAUsdf9e+wMYFkNHtd3uoYM=;
 b=MzJmWYceHOuoVnRKdNYznPHQEYT9XvoiROEDcf1kHBZdGSgWnemLQD26kGqUPj/y4p
 +vXY/pcXN5+1UpyUqmPf//ps6i20k4gq4YtAjiP3TJyk8kdI0rrm7NIcFfFwDH91sz+E
 SEIYL7P52l18Hg4Hg6wCUAiLRJrXZ79eGLs7BCdCfleRpFwrdDiP6bhmiD0qYZxrFLJq
 TJTsyPLvfHRKT6lQ55d2N+EzPPyiKCbQcng4S8qZCOx7JPtGvqcVy4L8O7/0tGGw3Qxn
 dOFfP466+iTmDL8Vm3190Llig8+sxJt3cIxLFQaOoS3Y7z2a3psU6QKlq1hR5jgXwJCl
 C1Kw==
X-Gm-Message-State: AOJu0YyvmCWySXkCO/eUp3gJ9NIIgie6zb0AfyVLe1ftab8tAF/Gizgr
 ABo8KyFp8sIntPmYyffstzH6iSX7MRaHWbyS2WypAYx1Z5D1l7Z6PiFR5hP/T4U9ff9ITl5AbRg
 TK7aJ4zV9PJgFLT4=
X-Received: by 2002:a05:600c:2907:b0:405:9666:5242 with SMTP id
 i7-20020a05600c290700b0040596665242mr1948438wmd.31.1696420097688; 
 Wed, 04 Oct 2023 04:48:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMjHWsjiCdMYbLrsPH6r1ojQ246Bwhnr+GfOkENHBo2i7QWXvxXpHQiUucD3cJB5VTfMKZbg==
X-Received: by 2002:a05:600c:2907:b0:405:9666:5242 with SMTP id
 i7-20020a05600c290700b0040596665242mr1948416wmd.31.1696420097270; 
 Wed, 04 Oct 2023 04:48:17 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 x15-20020a5d60cf000000b003271be8440csm3818801wrt.101.2023.10.04.04.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 04:48:16 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  dgilbert@redhat.com,
 pbonzini@redhat.com,  berrange@redhat.com,  armbru@redhat.com,
 eblake@redhat.com,  farosas@suse.de,  manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v11 02/10] migration: convert migration 'uri' into
 'MigrateAddress'
In-Reply-To: <20231004075851.219173-3-het.gala@nutanix.com> (Het Gala's
 message of "Wed, 4 Oct 2023 07:58:43 +0000")
References: <20231004075851.219173-1-het.gala@nutanix.com>
 <20231004075851.219173-3-het.gala@nutanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 13:48:15 +0200
Message-ID: <8734yq4ni8.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Het Gala <het.gala@nutanix.com> wrote:
> This patch parses 'migrate' and 'migrate-incoming' QAPI's 'uri'
> string containing migration connection related information
> and stores them inside well defined 'MigrateAddress' struct.
>
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


