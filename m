Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BBDB09E6D
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Jul 2025 10:54:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucgqV-00012o-67; Fri, 18 Jul 2025 04:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ucgqQ-0000xz-E0
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 04:53:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ucgqO-00017L-G8
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 04:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752828807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q19wn6ISCizGdXR5AvCwHZareuBWeQKslzPjVdnIOGU=;
 b=Im453In+RlK8W9SFSJrNR1EzPbHnmsIAVoXpCteaMroAXseKaj/QSDl1DCCFxYEo/dHF9L
 GuImUXp1mqHsvZt3oQ0iaPF3g9/46/vO6o3/Bdw/uPvCBTkdsS+w1e5JHE9dtKPt0s57/s
 WqkCL7JHI+B/InWar058NwXX72rIZV4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-UrgQ7njDPjiKJEir_9AVNg-1; Fri,
 18 Jul 2025 04:53:24 -0400
X-MC-Unique: UrgQ7njDPjiKJEir_9AVNg-1
X-Mimecast-MFC-AGG-ID: UrgQ7njDPjiKJEir_9AVNg_1752828802
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 684C41800286; Fri, 18 Jul 2025 08:53:22 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.19])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8EAAF1956089; Fri, 18 Jul 2025 08:53:17 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Luigi Rizzo <lrizzo@google.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH RFC v3 02/13] linux-headers: Update to Linux ~v6.16-rc5
 net-next
Date: Fri, 18 Jul 2025 10:52:28 +0200
Message-ID: <0bc9ef41193838559c8f4bf138cf4faf192849bc.1752828082.git.pabeni@redhat.com>
In-Reply-To: <cover.1752828082.git.pabeni@redhat.com>
References: <cover.1752828082.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Update headers to include the virtio GSO over UDP tunnel features

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
--
Note: while the relevant change are not into Linus's tree yet, they have
been merged in the net-next tree and they should land into the vanilla
tree during the next merge window.
---
 include/standard-headers/linux/ethtool.h     |  4 +--
 include/standard-headers/linux/vhost_types.h |  5 +++
 include/standard-headers/linux/virtio_net.h  | 33 ++++++++++++++++++++
 linux-headers/linux/vhost.h                  |  7 +++++
 4 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/include/standard-headers/linux/ethtool.h b/include/standard-headers/linux/ethtool.h
index cef0d207a6..eb80314028 100644
--- a/include/standard-headers/linux/ethtool.h
+++ b/include/standard-headers/linux/ethtool.h
@@ -2314,7 +2314,7 @@ enum {
 	IPV6_USER_FLOW	= 0x0e, /* spec only (usr_ip6_spec; nfc only) */
 	IPV4_FLOW	= 0x10, /* hash only */
 	IPV6_FLOW	= 0x11, /* hash only */
-	ETHER_FLOW	= 0x12, /* spec only (ether_spec) */
+	ETHER_FLOW	= 0x12, /* hash or spec (ether_spec) */
 
 	/* Used for GTP-U IPv4 and IPv6.
 	 * The format of GTP packets only includes
@@ -2371,7 +2371,7 @@ enum {
 /* Flag to enable RSS spreading of traffic matching rule (nfc only) */
 #define	FLOW_RSS	0x20000000
 
-/* L3-L4 network traffic flow hash options */
+/* L2-L4 network traffic flow hash options */
 #define	RXH_L2DA	(1 << 1)
 #define	RXH_VLAN	(1 << 2)
 #define	RXH_L3_PROTO	(1 << 3)
diff --git a/include/standard-headers/linux/vhost_types.h b/include/standard-headers/linux/vhost_types.h
index fd54044936..4a3aacc39e 100644
--- a/include/standard-headers/linux/vhost_types.h
+++ b/include/standard-headers/linux/vhost_types.h
@@ -110,6 +110,11 @@ struct vhost_msg_v2 {
 	};
 };
 
+struct vhost_features_array {
+	uint64_t count; /* number of entries present in features array */
+	uint64_t features[] __counted_by(count);
+};
+
 struct vhost_memory_region {
 	uint64_t guest_phys_addr;
 	uint64_t memory_size; /* bytes */
diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard-headers/linux/virtio_net.h
index 982e854f14..93abaae0b9 100644
--- a/include/standard-headers/linux/virtio_net.h
+++ b/include/standard-headers/linux/virtio_net.h
@@ -70,6 +70,28 @@
 					 * with the same MAC.
 					 */
 #define VIRTIO_NET_F_SPEED_DUPLEX 63	/* Device set linkspeed and duplex */
+#define VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO 65 /* Driver can receive
+					      * GSO-over-UDP-tunnel packets
+					      */
+#define VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM 66 /* Driver handles
+						   * GSO-over-UDP-tunnel
+						   * packets with partial csum
+						   * for the outer header
+						   */
+#define VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO 67 /* Device can receive
+					     * GSO-over-UDP-tunnel packets
+					     */
+#define VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM 68 /* Device handles
+						  * GSO-over-UDP-tunnel
+						  * packets with partial csum
+						  * for the outer header
+						  */
+
+/* Offloads bits corresponding to VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO{,_CSUM}
+ * features
+ */
+#define VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_MAPPED	46
+#define VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM_MAPPED	47
 
 #ifndef VIRTIO_NET_NO_LEGACY
 #define VIRTIO_NET_F_GSO	6	/* Host handles pkts w/ any GSO type */
@@ -131,12 +153,17 @@ struct virtio_net_hdr_v1 {
 #define VIRTIO_NET_HDR_F_NEEDS_CSUM	1	/* Use csum_start, csum_offset */
 #define VIRTIO_NET_HDR_F_DATA_VALID	2	/* Csum is valid */
 #define VIRTIO_NET_HDR_F_RSC_INFO	4	/* rsc info in csum_ fields */
+#define VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM 8	/* UDP tunnel csum offload */
 	uint8_t flags;
 #define VIRTIO_NET_HDR_GSO_NONE		0	/* Not a GSO frame */
 #define VIRTIO_NET_HDR_GSO_TCPV4	1	/* GSO frame, IPv4 TCP (TSO) */
 #define VIRTIO_NET_HDR_GSO_UDP		3	/* GSO frame, IPv4 UDP (UFO) */
 #define VIRTIO_NET_HDR_GSO_TCPV6	4	/* GSO frame, IPv6 TCP */
 #define VIRTIO_NET_HDR_GSO_UDP_L4	5	/* GSO frame, IPv4& IPv6 UDP (USO) */
+#define VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 0x20 /* UDPv4 tunnel present */
+#define VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6 0x40 /* UDPv6 tunnel present */
+#define VIRTIO_NET_HDR_GSO_UDP_TUNNEL (VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 | \
+				       VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6)
 #define VIRTIO_NET_HDR_GSO_ECN		0x80	/* TCP has ECN set */
 	uint8_t gso_type;
 	__virtio16 hdr_len;	/* Ethernet + IP + tcp/udp hdrs */
@@ -181,6 +208,12 @@ struct virtio_net_hdr_v1_hash {
 	uint16_t padding;
 };
 
+struct virtio_net_hdr_v1_hash_tunnel {
+	struct virtio_net_hdr_v1_hash hash_hdr;
+	uint16_t outer_th_offset;
+	uint16_t inner_nh_offset;
+};
+
 #ifndef VIRTIO_NET_NO_LEGACY
 /* This header comes first in the scatter-gather list.
  * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it must
diff --git a/linux-headers/linux/vhost.h b/linux-headers/linux/vhost.h
index d4b3e2ae13..d6ad01fbb8 100644
--- a/linux-headers/linux/vhost.h
+++ b/linux-headers/linux/vhost.h
@@ -235,4 +235,11 @@
  */
 #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
 					      struct vhost_vring_state)
+
+/* Extended features manipulation */
+#define VHOST_GET_FEATURES_ARRAY _IOR(VHOST_VIRTIO, 0x83, \
+				       struct vhost_features_array)
+#define VHOST_SET_FEATURES_ARRAY _IOW(VHOST_VIRTIO, 0x83, \
+				       struct vhost_features_array)
+
 #endif
-- 
2.50.0


