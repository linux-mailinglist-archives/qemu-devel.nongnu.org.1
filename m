Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB3B7B9BCF
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 10:25:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoJf4-00019K-9a; Thu, 05 Oct 2023 04:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qoJf2-00018P-ED
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 04:24:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qoJf1-0000OS-1J
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 04:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696494282;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=kkHjV/07KW2CAjMj81lflgFWuNdEkHcC2/rIcJAqHUk=;
 b=P/3qivZEpsNP5tH4IolKvK6dT61KvJbA/SWaDUs6rR86gI5Ks+Ip5dV64OE8/yMRFdt9K8
 uWI5Nh3Y0mHlxNu3u07eSdCLa3Ir+mxqLmtZP3YX/jiiTA/hRHrKFN/ZCAvZ92ocVAti7t
 Qoc/JePSL8KvtYiIwXNUCQO4Va5+y5w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-6TXuIX_xO2unjwXDoydFZA-1; Thu, 05 Oct 2023 04:24:40 -0400
X-MC-Unique: 6TXuIX_xO2unjwXDoydFZA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe182913c5so4768025e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 01:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696494279; x=1697099079;
 h=mime-version:date:reply-to:user-agent:references:message-id
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kkHjV/07KW2CAjMj81lflgFWuNdEkHcC2/rIcJAqHUk=;
 b=Tfcn0FKGOVWyDLGQpo6cGyORNbTVx5uyEawccQHzA1eFmKyfxZzET921ofBT7f+nbg
 N5M8DWTD6jY5KlaMcXA2aoLkFbvZLZauiZn4UqfUbAkUsOsfb793uKLazgb3+SvRefZR
 jYoQx/1CuB6SQJhsGMQqRUDZx3Tfon2aEucl9D3T04i5HDIfeGc3VO1iix+MuXr71XNZ
 8e9lwAmmGN0AD2PkrOBWxD//UcHz0nIoQW2eLRE1cbk4HQV8VT23dBg5G0iZsiaRnu6X
 hgEUWkrOCdWvoGoQ94R9g/HxrHW/S9mMViUBtGF0Jcq/1oxKw8rd19xQslE1oHeXH52J
 ZIzA==
X-Gm-Message-State: AOJu0YwZLBhAnujyTFyUfPar19y8jrJ+ZikGEVLDiJF0ZRF6+U17c+JD
 c2Exjd0lGb/r4AhAmeJ4ffO7kMqiB/hYO/bWls/3tv1X6EQeyaZnJNr73x96hXvN/c03iPgBdbW
 8YlclbhZdEks2FWA=
X-Received: by 2002:a05:600c:21d1:b0:405:1c14:9227 with SMTP id
 x17-20020a05600c21d100b004051c149227mr4766915wmj.33.1696494279592; 
 Thu, 05 Oct 2023 01:24:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFF5hkNPZpb60GybxPPVekb64Xw/XcN4oIkHUpP4ylz3JqtHU/OVYz/pxs2S5Cmi4qh+qnCDg==
X-Received: by 2002:a05:600c:21d1:b0:405:1c14:9227 with SMTP id
 x17-20020a05600c21d100b004051c149227mr4766897wmj.33.1696494279201; 
 Thu, 05 Oct 2023 01:24:39 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 s17-20020a1cf211000000b00405623e0186sm3236437wmc.26.2023.10.05.01.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 01:24:38 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v3 09/10] migration: Allow RECOVER->PAUSED convertion
 for dest qemu
In-Reply-To: <20231004220240.167175-10-peterx@redhat.com> (Peter Xu's message
 of "Wed, 4 Oct 2023 18:02:39 -0400")
Message-ID: <871qe9pku2.fsf@secure.mitica>
References: <20231004220240.167175-1-peterx@redhat.com>
 <20231004220240.167175-10-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 05 Oct 2023 10:24:37 +0200
MIME-Version: 1.0
Content-Type: text/plain
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

Peter Xu <peterx@redhat.com> wrote:
> There's a bug on dest that if a double fault triggered on dest qemu (a
> network issue during postcopy-recover), we won't set PAUSED correctly
> because we assumed we always came from ACTIVE.
>
> Fix that by always overwriting the state to PAUSE.
>
> We could also check for these two states, but maybe it's an overkill.  We
> did the same on the src QEMU to unconditionally switch to PAUSE anyway.
>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued


