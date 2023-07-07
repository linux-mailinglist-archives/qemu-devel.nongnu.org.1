Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F09D974AF1E
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 12:54:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHj4x-0007Bm-2M; Fri, 07 Jul 2023 06:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qHj4u-0007Bc-Q8
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 06:52:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qHj4t-0007UD-GT
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 06:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688727161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=ZjWnavCEFPqNwb5j4SPJmqTPhW690NvW104mfkQFq8PtIYe3TJJJFOy6eKPw/eXdRcQTr7
 ed0KOwYr0+kTYdDOTwPtH6Hm+LZmYp5DcYzFM4TUkUv+z5bImfj/MQGJUGmZViCz3L0Bcd
 svQ8rn7EGCH1h88l01dushV0it4lzFM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-Whisqp_UM5GNMa5mIY14bw-1; Fri, 07 Jul 2023 06:52:40 -0400
X-MC-Unique: Whisqp_UM5GNMa5mIY14bw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-51e10b6148cso2144628a12.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 03:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688727159; x=1691319159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=YK1W7llCHeVcoz2C02JFrMJ46appshoU0TgTYIJcbZ5R2XlQRUogrDO1pHD62jz/rX
 w7SASlRtAUYcww0e0FspZPNQMfAh4elmEQGZeEakrDwAUHkz2sTe9xOAQbtiWn/XQ91i
 J6Bl1RkMYGMZldFzkP+OXfQArG3goZVzzY4CI0jPONWelW+C2ptonqzDWxcB6zyTkhn9
 UxM4HbVdqzKsNwq6RL6bUgrVAHlvUlWp33kxuBjVPM4miH+QdQOtgLNf9hK+Kc6f26jV
 M3+Dj6fsZb1k4KEimnp/lNnnxk5pIVUdObRO90u8yhSv/ZhZ+y5E7xeumxjxqB/b6EU3
 8NOg==
X-Gm-Message-State: ABy/qLY1i9E8Fk+LvC1MW4mDvyVknvIIa93LkBdB+ACTjRli1tyNP76o
 tGKfIrZ2tYLzih45oHvwRIuVhMMJc2kmswaie98bb60kRBEMGPaT2qT9otPe7iHTAfnjS9W81xT
 ACgflhT6h6D44duZAoQJbs2I=
X-Received: by 2002:aa7:d983:0:b0:51e:1c5c:b97f with SMTP id
 u3-20020aa7d983000000b0051e1c5cb97fmr4723158eds.2.1688727159224; 
 Fri, 07 Jul 2023 03:52:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE7jSJKxvDyv4Lnd5BXmkwOTKs+oOMOh0xFlXb8CeCA44tPSod0hGI2+xul3hKYQxcSLYqY6Q==
X-Received: by 2002:aa7:d983:0:b0:51e:1c5c:b97f with SMTP id
 u3-20020aa7d983000000b0051e1c5cb97fmr4723141eds.2.1688727158966; 
 Fri, 07 Jul 2023 03:52:38 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 n24-20020aa7d058000000b0051df583ca96sm1880854edo.43.2023.07.07.03.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 03:52:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, imammedo@redhat.com,
 xiaoyao.li@intel.com, lei4.wang@intel.com, qian.wen@intel.com
Subject: Re: [PATCH v2 0/6] Add new CPU model GraniteRapids
Date: Fri,  7 Jul 2023 12:52:37 +0200
Message-ID: <20230707105237.74092-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706054949.66556-1-tao1.su@linux.intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Queued, thanks.

Paolo


