Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0607330D6
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 14:09:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA8Fs-0002Zi-MT; Fri, 16 Jun 2023 08:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qA8Fq-0002ZW-OS
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 08:08:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qA8Fo-00007N-KI
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 08:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686917314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3yDdiA5CJSKGBC7Q1z3xT2lz0WLWXo+kaCp4BHVNhH4=;
 b=ZS06rgdG+YUU6q5SsTSjZhPAhJT7smhCspWamdz1AhfrwFfYLm7gRr/dXJNrMUu5c4SyHX
 UMHL/KWqaxkP8SnqluYvlbBGT8+DOGZXMS173aEfNvat8LXhbStABnKvmPTdlMR3Q3Z9ca
 CwGryRxtjdp7cjCyGDw287BAXv62Qmo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-B8lcuyhAP9Owa8fCt11xrw-1; Fri, 16 Jun 2023 08:08:33 -0400
X-MC-Unique: B8lcuyhAP9Owa8fCt11xrw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-94a348facbbso47022066b.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jun 2023 05:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686917312; x=1689509312;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3yDdiA5CJSKGBC7Q1z3xT2lz0WLWXo+kaCp4BHVNhH4=;
 b=TV8J/iC/4fj9eflmTpeu8c4VLT/B5iU2Wkcl9OdsQod/i1P9YHs4PfgOxcOFFaFoSn
 MacmjgRC6HSgJY1djVZUK+WW2mnxDmQpyEa+jUCeESEmbHELT5kdOGuKOQSPkj+wugTI
 vrxxXzCPpExibRcCkLIi2SZneDy2YVRD6rKqnVRM/NoCvfW03izyPndheKRyPWvEEmv0
 PG8v5p31YJ2jZl5X7FOeeb1m/2+M5ZdiwEmYEk6MyMrzynKpY5jseZ9d6NY863MVUCpU
 KmwSCpjUK6c1Np5H7/YZ89ngErI6r3PW2fwx88s6met5cKjXCfgC7PJ4gkK96Q1l67Tk
 oW+w==
X-Gm-Message-State: AC+VfDz03tb+Qyf0WrJzthKUA2KbbKLv7dQ9AH/1uxwLaDznSD7OqA7U
 ekBuWAzcqvXIi2mxW6q1qH8M6vLNvyFA7Pda1bGm3pqx11KbnUn48U1p866OgbOA3642W4sBp/5
 IlbmQETDGQmGkxGYPfICbVu8XyyJeSWfvpWW5CvYBorkOuOMz+7VPqK85F2i7DRIbgr2kLAhsYx
 xOng==
X-Received: by 2002:a17:906:f112:b0:96a:6e42:7123 with SMTP id
 gv18-20020a170906f11200b0096a6e427123mr1331839ejb.36.1686917311750; 
 Fri, 16 Jun 2023 05:08:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6FylYa3G0oA79l1DmwK49tMp0EnFSO8b2TNjk/ArZfOcShlrsoWfWrCCrPj2UUUJ6Ww3eS2A==
X-Received: by 2002:a17:906:f112:b0:96a:6e42:7123 with SMTP id
 gv18-20020a170906f11200b0096a6e427123mr1331826ejb.36.1686917311246; 
 Fri, 16 Jun 2023 05:08:31 -0700 (PDT)
Received: from [100.69.166.131] ([147.229.117.1])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a1709060e4d00b00978886c7cdbsm10575751eji.183.2023.06.16.05.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jun 2023 05:08:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com
Subject: [qemu-web PATCH] include Dockerfile used to proxy qemu.org to
 gitlab.io
Date: Fri, 16 Jun 2023 14:08:29 +0200
Message-Id: <20230616120829.35011-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

The server configuration used to actually publish qemu-web.git
to qemu.org together with the sphinx documentation, right now,
is hidden in the machine that runs qemu.org.

Include it in the qemu-web.git website for documentation purpose,
in the format of a Dockerfile that you can use to run your own
qemu.org website.

Note: this container is not yet in use, but it is already live
and can be tested by adding

20.218.253.93   qemu.org www.qemu.org git.qemu.org qemu-project.org www.qemu-project.org git.qemu-project.org

to your /etc/hosts file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 container/Dockerfile         |  6 ++++
 container/README             | 31 +++++++++++++++++++++
 container/conf.d/git.conf    | 13 +++++++++
 container/conf.d/noname.conf | 11 ++++++++
 container/conf.d/ssl.conf    |  1 +
 container/conf.d/www.conf    | 54 ++++++++++++++++++++++++++++++++++++
 6 files changed, 116 insertions(+)
 create mode 100644 container/Dockerfile
 create mode 100644 container/README
 create mode 100644 container/conf.d/git.conf
 create mode 100644 container/conf.d/noname.conf
 create mode 100644 container/conf.d/ssl.conf
 create mode 100644 container/conf.d/www.conf

diff --git a/container/Dockerfile b/container/Dockerfile
new file mode 100644
index 0000000..e22d646
--- /dev/null
+++ b/container/Dockerfile
@@ -0,0 +1,6 @@
+FROM quay.io/centos/centos:stream9
+EXPOSE 80
+RUN dnf install -y httpd-core mod_ssl
+COPY conf.d /etc/httpd/conf.d
+CMD /usr/sbin/httpd -DNO_DETACH -DFOREGROUND
+
diff --git a/container/README b/container/README
new file mode 100644
index 0000000..ea764ff
--- /dev/null
+++ b/container/README
@@ -0,0 +1,31 @@
+This is a Dockerfile for a container that serves the following hosts:
+
+- qemu.org, www.qemu.org: a proxy server that "hides" the fact that
+  the QEMU web pages are actually hosted as GitLab pages under either
+  qemu-project.gitlab.io/qemu (the documentation) or
+  qemu-project.gitlab.io/qemu-web (the main website)
+
+- git.qemu.org: a simple redirect to gitlab.com/qemu-project for
+  both web browsers and git's smart HTTP backend
+
+
+A sample systemd service that publishes the website on port 8082
+is as follows:
+
+```
+[Unit]
+Description=Podman instance control service for Apache proxy server
+Requires=network.target
+After=network.target
+StartLimitIntervalSec=0
+
+[Service]
+Restart=always
+ExecStartPre=-podman stop qemu-web ; -podman rm qemu-web
+ExecStart=podman run --name qemu-web --publish=8082:80 qemu:qemu-web
+ExecStop=podman stop -t 10 qemu-web
+RestartSec=60
+
+[Install]
+WantedBy=default.target
+```
diff --git a/container/conf.d/git.conf b/container/conf.d/git.conf
new file mode 100644
index 0000000..13093c5
--- /dev/null
+++ b/container/conf.d/git.conf
@@ -0,0 +1,13 @@
+<VirtualHost *:80>
+    ServerName git.qemu.org
+    ServerAlias git.qemu.org
+
+    RewriteEngine On
+
+    RewriteRule ^/(git/)?([^/?;]+)\.git(/?|/HEAD|/info/.*|/objects/.*|/git-(upload|receive)-pack)$ http://gitlab.com/qemu-project/$2$3 [R,L]
+    RewriteRule ^/$  https://gitlab.com/qemu-project/ [R]
+    RewriteRule ^(/[^/?;]+\.git)$ https://gitlab.com/qemu-project/$1/ [R]
+
+    Options -Indexes
+
+</VirtualHost>
diff --git a/container/conf.d/noname.conf b/container/conf.d/noname.conf
new file mode 100644
index 0000000..db17b95
--- /dev/null
+++ b/container/conf.d/noname.conf
@@ -0,0 +1,11 @@
+<VirtualHost *:80>
+    ServerName qemu.org
+    ServerAlias qemu.org
+
+    RewriteEngine On
+
+    RewriteRule ^(.*) https://www.qemu.org$0 [R=301]
+
+    Options -Indexes
+
+</VirtualHost>
diff --git a/container/conf.d/ssl.conf b/container/conf.d/ssl.conf
new file mode 100644
index 0000000..b56a8a8
--- /dev/null
+++ b/container/conf.d/ssl.conf
@@ -0,0 +1 @@
+# do nothing, ssl is handled outside the container
diff --git a/container/conf.d/www.conf b/container/conf.d/www.conf
new file mode 100644
index 0000000..1904b5a
--- /dev/null
+++ b/container/conf.d/www.conf
@@ -0,0 +1,54 @@
+<VirtualHost *:80>
+    ServerName www.qemu.org
+    ServerAlias www.qemu.org
+
+    RewriteEngine On
+    RewriteRule ^/docs/master(/.*|$) https://qemu-project.gitlab.io/qemu$1 [NE,P,L]
+    Header edit Location ^(http:|https:)?//qemu-project\.gitlab\.io/qemu/ https://www.qemu.org/docs/master/
+
+    # Stable pointers within the documentation
+    RewriteRule /contribute/submit-a-patch/ /docs/master/devel/submitting-a-patch.html [R=302,L]
+    RewriteRule /contribute/submit-a-pull-request/ /docs/master/devel/submitting-a-pull-request.html [R=302,L]
+    RewriteRule /contribute/trivial-patches/ /docs/master/devel/trivial-patches.html [R=302,L]
+
+    RewriteRule ^/(.*) https://qemu-project.gitlab.io/qemu-web/$1 [NE,P,L]
+    Header edit Location ^(http:|https:)?//qemu-project\.gitlab\.io/qemu-web/ https://www.qemu.org/
+
+    Options -Indexes
+
+    RewriteEngine On
+
+    SSLProxyEngine on
+    SSLProxyCheckPeerCN on
+    SSLProxyCheckPeerExpire on
+
+    ProxyRequests Off
+
+    DocumentRoot /var/www/html
+    Options -Indexes
+
+    <Directory /var/www/html>
+      Options +FollowSymLinks
+      AllowOverride FileInfo
+
+      FileETag All
+    </Directory>
+
+    <Location />
+      CacheDefaultExpire 600
+      CacheMaxExpire 86400
+      CacheLastModifiedFactor 0.5
+
+      Header merge Cache-Control public
+    </Location>
+
+    <Location /assets>
+      ExpiresActive on
+      ExpiresDefault "access plus 1 week"
+    </Location>
+    <Location /screenshots>
+      ExpiresActive on
+      ExpiresDefault "access plus 1 week"
+    </Location>
+
+</VirtualHost>
-- 
2.40.1


