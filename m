Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DCF7B7E7D
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 13:53:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo0Qn-0005fu-HJ; Wed, 04 Oct 2023 07:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo0Ql-0005fU-2N
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 07:52:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo0Qj-00063F-IO
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 07:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696420360;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vIZEl/iFpDdH+I3pse9UBy73zRI8hFGiR0HgC+Lre7w=;
 b=g/2gxtp8e4geiBjbDOAqrc3xTgtiSXp9HnekT6s0/jUD3pxNe8eiTGiqhxpwRIHNAaSQyx
 mWrBM2VcMSrhfv6TqQiq/HLpiLNwl29QZbYuRlmwO4naN83NY/fX/djB4mY1dgMUkH6QSe
 EELjD+zt58r2xQgFqf4eaUE1Erxh2xo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-Y7Wrf-X5OY64NXQzjRuvow-1; Wed, 04 Oct 2023 07:52:18 -0400
X-MC-Unique: Y7Wrf-X5OY64NXQzjRuvow-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32172e3679bso1462625f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 04:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696420337; x=1697025137;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vIZEl/iFpDdH+I3pse9UBy73zRI8hFGiR0HgC+Lre7w=;
 b=EYNzXDS5vAAciRD8t/ci48BI4voHRjGHCD3e9iiuzj+E0PL4tBzR215eVu7+M4k+jX
 ODLCOkDdZGLwolSuYLPFbEsGFNtzSbD5uYSXVqGNb6BjI+koTK5oglveCUH835Cb5kcs
 Mwg3AU11Eb3RKjdDAOE2NTbDMCnYGGU3C3yAZoJ4I101tFY5Psq8vKMQTjFO7QdtcxKU
 Jn1jKl37RLYqeWc96p8lMP9ZPlJaMc8aWobsl7BcCdq8ewBEsc82tCbJPftownvHMEwM
 BzLzJpZ+Zj8qDlrXZIz7PZg7fgDLLrKtMpYauD7mWOWTjTjPXXpof7ztOA6w1vPZybxS
 brKQ==
X-Gm-Message-State: AOJu0YyLuk4yVeBVo30Eesmbm5+3jWU1HVI+uSR2WaFvu37KgjaDFULC
 kxKZPrAa5Koj3brfegxAzMEpEZc9l7hLp4PTLOfMjX0Rim8FyPBLntjCxTg273jihTP3WmBm34d
 JtI9VPD41iS88+gQ=
X-Received: by 2002:a05:6000:11c2:b0:31a:dc2e:2db2 with SMTP id
 i2-20020a05600011c200b0031adc2e2db2mr1822025wrx.49.1696420337476; 
 Wed, 04 Oct 2023 04:52:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJEnyliowAJgWqHo0S3OuvwHN5AGC1dYCyNCu6kqizPPZr1G3J/IcfLuIRykWJtaStRXSK8Q==
X-Received: by 2002:a05:6000:11c2:b0:31a:dc2e:2db2 with SMTP id
 i2-20020a05600011c200b0031adc2e2db2mr1822005wrx.49.1696420337182; 
 Wed, 04 Oct 2023 04:52:17 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 f5-20020adff8c5000000b00327b5ca093dsm3797411wrq.117.2023.10.04.04.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 04:52:16 -0700 (PDT)
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
Date: Wed, 04 Oct 2023 13:52:15 +0200
Message-ID: <87sf6q38r4.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

queued.


