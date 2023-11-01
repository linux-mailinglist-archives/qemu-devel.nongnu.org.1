Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 538407DDCC4
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 07:40:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy4sB-0001j7-7b; Wed, 01 Nov 2023 02:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qy4s9-0001iz-7p
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 02:38:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qy4s7-0005kV-NJ
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 02:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698820714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3/6Mk6mvGgSvrFr8ePil4HbTucXVLheeaO0aJ6mmVlc=;
 b=QCaJn1xHzirgDrTncmJG+RUNEOAlv+LV9xe+IwNURVFIblErFREtpXgNvqUE2rkQMRyX/s
 vNd2q7CN1FrqrLGB2oGxqpIWUTCWKN/97oQrJg246yvyflZl9gERTsup+Vmk4/mTnelcF1
 Bqt5dJbn01m9/DzxoQ4Rv6HRP0e/o50=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-KVKXJSujMg27FehOOzyVfA-1; Wed, 01 Nov 2023 02:38:29 -0400
X-MC-Unique: KVKXJSujMg27FehOOzyVfA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32f8c4e9b88so364292f8f.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 23:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698820708; x=1699425508;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3/6Mk6mvGgSvrFr8ePil4HbTucXVLheeaO0aJ6mmVlc=;
 b=uaX0o/lWYWt5PweefhsOOPFJGlAYWsLJnO1tFEqB4dqU52AzYNiPMXzfQhZdbpDl96
 18sTggv3BKCxap+jt33BnAcOAP2w+KDow3/7D7/jMpH3zdedxGipwvyTWIoeCU1lScye
 C0AdKhCB3CAdpnWye/S0ZLXVVI1VBqaEOI0Tw+Z6uwsxoFL37qt6fWXPl+989SuviXA4
 IW8t6dm8I3SQdnbp0qDL46ipZT96DxpTUBm1516/289cIKqxf4Ie4tUZd2H4ZNhKFmWr
 HLVTAegkjfrJ243ujQVUcpXMC2sHRbjnYB1vKf6vCOKgJvT+AQJXbEO24zcYNC0Fojjt
 l3Eg==
X-Gm-Message-State: AOJu0Yx5pTy2q2Q7czMiH1qUINTCmXFYUu6fL6cH+K+L/BbzkBfGvTOa
 aVMZyrWbfQD4QTKFsnObzFzQG/zk9/jgOpiSB88XczRlkAr9NDBj8ud2ZsumjDa6mztnJ/ULHUd
 8RlmNx6n/tfecNkw=
X-Received: by 2002:a05:6000:1565:b0:32d:8c67:be05 with SMTP id
 5-20020a056000156500b0032d8c67be05mr4958790wrz.22.1698820708216; 
 Tue, 31 Oct 2023 23:38:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnJUqLUVcoQxUFS1FgtW+X+U7e5t1P0EcWOaGl+CaJF95ywFkBpgSDMjstgtbXz9NgOVyLZg==
X-Received: by 2002:a05:6000:1565:b0:32d:8c67:be05 with SMTP id
 5-20020a056000156500b0032d8c67be05mr4958776wrz.22.1698820707919; 
 Tue, 31 Oct 2023 23:38:27 -0700 (PDT)
Received: from redhat.com ([2a02:14f:173:14b6:b6f1:4797:8f5d:fa41])
 by smtp.gmail.com with ESMTPSA id
 q8-20020adfcd88000000b003197869bcd7sm3309721wrj.13.2023.10.31.23.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 23:38:27 -0700 (PDT)
Date: Wed, 1 Nov 2023 02:38:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 qemu-devel@nongnu.org, Andrew Melnychenko <andrew@daynix.com>
Subject: Re: [PATCH v6 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
Message-ID: <20231101023805-mutt-send-email-mst@kernel.org>
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
 <20231030051356.33123-12-akihiko.odaki@daynix.com>
 <CAOEp5OdEEVcojjwCOU+9Z5yBKN+e5iNbAMOA5d-97D81N4Y0tw@mail.gmail.com>
 <58fb3b75-dd69-4715-a8ec-4c3df3b7e4c5@daynix.com>
 <CAOEp5Oern10jW8Pi-_mceU_ZJVD=a1f3tW8rB2O4efLX45-nvw@mail.gmail.com>
 <8880b6f9-f556-46f7-a191-eeec0fe208b0@daynix.com>
 <CACGkMEv=A0KS-LtgZmsMehdoUL=EuQzhkfNipKaV1kdUr2Y5Bw@mail.gmail.com>
 <d0db0fb1-0a58-45b7-a623-df6ee9096e2e@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0db0fb1-0a58-45b7-a623-df6ee9096e2e@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Nov 01, 2023 at 01:50:00PM +0900, Akihiko Odaki wrote:
> We had another discussion regarding migration for patch "virtio-net: Do not
> clear VIRTIO_NET_F_HASH_REPORT". It does change the runtime behavior so we
> need to take migration into account. I still think the patch does not
> require a compatibility flag since it only exposes a new feature and does
> not prevent migrating from old QEMU that exposes less features. It instead
> fixes the case where migrating between hosts with different tap feature
> sets.

When in doubt, add a compat flag.

-- 
MST


