Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFA97DCF9A
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:49:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxq3D-0008OQ-Ot; Tue, 31 Oct 2023 10:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxq31-0008IX-SL
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:48:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxq2z-0002tq-Fb
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698763728;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w7toTcC9ZtynQDA63QCIxGfaKsnak6Wz7YLuOt8i5o8=;
 b=NjGwy8TFuSrGxVcFDGNmadTOBm7JHxK9aRESP4//ggBrc79omfKYkBhUW76P1u7lYwpLZc
 iSko313UyRApAIopihuCEfEZcwaknAKtX/sCBuPpym2UaFsvTA5bTX+9jOqbvOrzbcYjti
 PEAkBtf8OF1pR/s/6eQtgrTvSvUdMk4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-FiXmNbcdOX60T4WDT7s3kQ-1; Tue, 31 Oct 2023 10:48:37 -0400
X-MC-Unique: FiXmNbcdOX60T4WDT7s3kQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4083fec2c30so40686815e9.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698763715; x=1699368515;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w7toTcC9ZtynQDA63QCIxGfaKsnak6Wz7YLuOt8i5o8=;
 b=YJdG/WwUvme4TqCOvEPRhUlk5X/t653d03mRg50wMUM2qhOqLFMRJr7nP/9GaVM53g
 Q7jstZYDNyrYJ7ppLfCz8V4LHWiDMCuQYvK1nfMCn1q26fKxweEpdFAbV2PjYRQTf1Ng
 kDf7fpAxXd4dyOV3EIVYOPJSdKcv78ohKjG3AOdkcvTZp57T+0BYOIhCgvv0PSH0PC4O
 ZDGkb0AiZG1Sa0wiq9qQ52zYJdlRG4LsRI42SwhUWOLKeCkq8DTcAa+OX9WgYjkSSzk/
 0OLFiPWLfCjYzOvpu/93fcTUi3fkRiuIu9ggCB2tmOgTYroEDS9IilbMyYQJMDYB/T2c
 WaJA==
X-Gm-Message-State: AOJu0YxuncRqxCqrNj20MQ4HSeu6rGwbODmorJcrZXmRieS2WW/bp/7A
 0R8gDw3fDmo8Mbk0gnF/+wORkYyR+KeDdxFN9zoQYmS8Qvdt539z9sHMBIh7oYQx7DNsKIW7mEn
 bK591S3cJSZtkZF6aCk5VF+S+lA==
X-Received: by 2002:a05:600c:1d08:b0:408:4d0e:68ac with SMTP id
 l8-20020a05600c1d0800b004084d0e68acmr10437306wms.32.1698763714880; 
 Tue, 31 Oct 2023 07:48:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaXaAKvD9llNaBJovARGKufRSKNk4NK3xqwExbLToMNE56rj4UNKedyQdbqMQ5/kRS5V2ixA==
X-Received: by 2002:a05:600c:1d08:b0:408:4d0e:68ac with SMTP id
 l8-20020a05600c1d0800b004084d0e68acmr10437289wms.32.1698763714577; 
 Tue, 31 Oct 2023 07:48:34 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 l26-20020a05600c1d1a00b0040839fcb217sm2037073wms.8.2023.10.31.07.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 07:48:33 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  dgilbert@redhat.com,
 pbonzini@redhat.com,  berrange@redhat.com,  armbru@redhat.com,
 eblake@redhat.com,  manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com,  Het Gala <het.gala@nutanix.com>,  Peter
 Xu <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v15 02/14] fixup! migration: New QAPI type 'MigrateAddress'
In-Reply-To: <20231023182053.8711-3-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 23 Oct 2023 15:20:41 -0300")
References: <20231023182053.8711-1-farosas@suse.de>
 <20231023182053.8711-3-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 15:48:33 +0100
Message-ID: <875y2m7sqm.fsf@secure.mitica>
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
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Merging with previous one.


