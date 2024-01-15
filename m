Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE3D82D443
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 07:40:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPGcy-000560-QO; Mon, 15 Jan 2024 01:39:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPGcu-00055f-3g
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:39:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPGcs-0007G2-NB
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:39:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705300753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kw2nQi6/7bB6DgXFFlH2uC74+8Jbl9cvmIvbV5RflG4=;
 b=TxzzzbhxQkaqzB1at0Q3ZRAhxeP5OU8RVUT05S68j968BtScerYo3ReOhTQiZ07e2vhdVC
 6jLIB5DlYEKEx8ww0w5TvCql0kOwSqFdd5BGwLR2ESFCbVUZ8d3Oz6vXyHGL54dhRCyHbT
 bRooVCbvimDTw0jgefMir+UdvlGfanw=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-P05ZKN7WMkmwXs_BurwSLg-1; Mon, 15 Jan 2024 01:39:05 -0500
X-MC-Unique: P05ZKN7WMkmwXs_BurwSLg-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6d99cdbeb9dso2148938b3a.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 22:39:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705300745; x=1705905545;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kw2nQi6/7bB6DgXFFlH2uC74+8Jbl9cvmIvbV5RflG4=;
 b=NUdX2EgE4zb0L+LOufyrm8wF7u8Odb0QOKG57MVQU/9QDzybfcXHxjAGJy5Lmz4oQi
 u6c2MEI7UxbYGguzC7bK8dAeLoHy1y916vp7Ot7DCDwchM/b3CEwQM3c7dMHTyqZD5Kp
 J7govvaP+d7ihpLSIoU9lAavAQAzYVzvr4j47FnWUmGAAVqi7MQGAUIHFz0LbFydNDkp
 JuSGCsgCbk0c7XpOEL1YeaJ4W6ayDcesDuRc7SzEfM/Tr2DBsk56uknOIFqlwspwjYEx
 5ykydnhM9RXWn3FbBn7ruk0ziLFYko6BLYMKkv9zuTyFzBvC8OQ+K48+4I1WE6tm8h7+
 wOrw==
X-Gm-Message-State: AOJu0Yx0rWag7f1ycs0eBiUXQqJj1bcg05qhyZ+fLZ/hW9A5A7tOTaoX
 5j1n2CzUXXS0L9AmD9mEKlYyZMmBy0HEAwIJa/12pkoWN7jM68Rw00tHkpS2E8xhTRzHvQhC/fT
 PnSQiaAyrhl69vVYSkpB4Wyc=
X-Received: by 2002:a05:6a00:2384:b0:6da:4e24:87d9 with SMTP id
 f4-20020a056a00238400b006da4e2487d9mr10960577pfc.3.1705300744839; 
 Sun, 14 Jan 2024 22:39:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSAa9X5GDftPO/RnUxd8xSplCgZgPbs9RUE6f+d1KUARSlPff33I5JWON2b5gG27FprF9/6w==
X-Received: by 2002:a05:6a00:2384:b0:6da:4e24:87d9 with SMTP id
 f4-20020a056a00238400b006da4e2487d9mr10960562pfc.3.1705300744605; 
 Sun, 14 Jan 2024 22:39:04 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 c23-20020aa78817000000b006d96dc803b3sm7168155pfo.12.2024.01.14.22.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 22:39:04 -0800 (PST)
Date: Mon, 15 Jan 2024 14:38:55 +0800
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V2 02/11] migration: remove error from notifier data
Message-ID: <ZaTS_-CH9lCSz1J-@x1n>
References: <1705071910-174321-1-git-send-email-steven.sistare@oracle.com>
 <1705071910-174321-3-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1705071910-174321-3-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
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

On Fri, Jan 12, 2024 at 07:05:01AM -0800, Steve Sistare wrote:
> Remove the error object from opaque data passed to notifiers.
> Use the new error parameter passed to the notifier instead.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


