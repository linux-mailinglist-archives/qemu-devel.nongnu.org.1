Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BB1712EC5
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 23:11:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2eiS-00022P-Lu; Fri, 26 May 2023 17:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2eiR-0001zl-6U
 for qemu-devel@nongnu.org; Fri, 26 May 2023 17:11:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2eiP-0004fG-Qr
 for qemu-devel@nongnu.org; Fri, 26 May 2023 17:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685135468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vReq70GjBW3QODGrXFj4HjmVZ3nWmJ6Z+fTSdP48/mc=;
 b=Kf+uyFekdYv1VWByDUjFBsa1LOxESTvrN1ZhGMkyNd8vrbl9HntTjFgnMxwTeoWMQX941v
 VWB0jFTeALLu4bfdljflO/sX77x/zskQzyce8H8VE8YlK/RnqjhG/rVfblTcc+4VPhhz3W
 U4nQ/FAuGqaneCI7wb7Xj6WNjNzfeWo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-6UNAlp66O-G9dvSi2HwpAw-1; Fri, 26 May 2023 17:10:59 -0400
X-MC-Unique: 6UNAlp66O-G9dvSi2HwpAw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-625917b68cbso2183936d6.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 14:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685135458; x=1687727458;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vReq70GjBW3QODGrXFj4HjmVZ3nWmJ6Z+fTSdP48/mc=;
 b=ebdm7kOFvOOiXobEwMflKzkDf8WWROEYFspcXMxkZgKHoxnL32MgViJZ+n1M5M2MdV
 D2DEccmAlh8tQMxkFI901g+DPpFHl1sOp/cFv5ts0jItWagY9F9py/4uIchveIcwqzcF
 c81YPltor2uDgAZG371X2f0Y3qIt6i+loMIllNGF4jTsgMI8Gbc8ed/stWyVYwnPeI7T
 5s47zfHr6rgMVyCMvY50I5G+7VUvLWe89SO1pywFcIdb5XXN6d2UI+hWLFhNj2BziWge
 8ociVZdder1ILHXgCyp7yasRGiDTLqYvczYpJfWvxgPw1wcC/cCUV50h6OlnFn0DsHlt
 AfCQ==
X-Gm-Message-State: AC+VfDw2M9Ff+aLFonJeJvWnAqty1xbPt3w/3qP6CUMtsLXbUk/Q3L8e
 gFFHOgxrTgvRq6P7I0UsYW0mbzp9qcEbVmfsttb1mu7MBL5YnOUmd++zBPs5tQ+7B+V6LYgEpY+
 1wonDTQWvNGO5b0/Hw2e7zHM=
X-Received: by 2002:a05:6214:1c48:b0:5ed:c96e:ca4a with SMTP id
 if8-20020a0562141c4800b005edc96eca4amr3413213qvb.1.1685135457916; 
 Fri, 26 May 2023 14:10:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ533SSaWy6z0HFsVgprXWD8Al1V28MScjV0ptjDtsSIOTUhOTmGcs+IdjHF+5BhPW8sWcV3XA==
X-Received: by 2002:a05:6214:1c48:b0:5ed:c96e:ca4a with SMTP id
 if8-20020a0562141c4800b005edc96eca4amr3413205qvb.1.1685135457708; 
 Fri, 26 May 2023 14:10:57 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 l6-20020ad44526000000b005dd8b9345f6sm1456663qvu.142.2023.05.26.14.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 14:10:57 -0700 (PDT)
Date: Fri, 26 May 2023 17:10:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 3/5] migration/rdma: We can calculate the rioc from the
 QEMUFile
Message-ID: <ZHEgYH7lAcv3ERVx@x1n>
References: <20230504114443.23891-1-quintela@redhat.com>
 <20230504114443.23891-4-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230504114443.23891-4-quintela@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, May 04, 2023 at 01:44:41PM +0200, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


